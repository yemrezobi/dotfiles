local M = {}

M.base = function()
  local mapopts = { silent = true, noremap = true }
  vim.g.mapleader = ' '

  -- Clear search highlighting
  vim.keymap.set('n', '<Esc>', '<Cmd>noh<CR>', mapopts)

  -- Exit insert mode
  vim.keymap.set('i', 'jk', '<Esc>', mapopts)
  vim.keymap.set('i', 'kj', '<Esc>', mapopts)
  vim.keymap.set('n', '<C-s>', '<Cmd>w<CR>', mapopts)

  -- CR to insert line below, C-CR to insert line above cursor
  mapopts.expr = true
  vim.keymap.set('n', '<CR>', function() return (vim.o.buflisted and vim.o.filetype ~= 'qf') and 'o<Esc>' or '<CR>' end,
    mapopts)
  vim.keymap.set('n', '<NL>', function() return (vim.o.buflisted and vim.o.filetype ~= 'qf') and 'O<Esc>' or '<NL>' end,
    mapopts)
end

M.get_project_base = function()
  -- git repo root
  local root_dir = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if root_dir.code == 0 then
    return root_dir.stdout
  end

  -- first lsp workspace
  local workspaces = vim.lsp.buf.list_workspace_folders()
  if #workspaces > 0 then
    return workspaces[1]
  end

  -- return cwd if nothing else matches
  return vim.loop.cwd()
end

M.telescope = function()
  local builtin = require('telescope.builtin')
  local mapopts = { noremap = true, silent = true, }
  vim.keymap.set('n', '<Leader>ff', function() builtin.find_files({ cwd = M.get_project_base() }) end, mapopts)
  vim.keymap.set('n', '<Leader>fg', function() builtin.live_grep({ cwd = M.get_project_base() }) end, mapopts)
  vim.keymap.set('n', '<Leader>fb', function() builtin.buffers() end, mapopts)
  vim.keymap.set('n', '<Leader>fh', function() builtin.help_tags() end, mapopts)
  vim.keymap.set('n', '<Leader>fr', function() builtin.lsp_references() end, mapopts)
  vim.keymap.set('n', '<Leader>fu', function() require('telescope').extensions.undo.undo() end, mapopts)
  vim.keymap.set('n', '<Leader>fc', function() builtin.colorscheme() end, mapopts)
  vim.keymap.set('n', '<Leader>fo', function() builtin.oldfiles() end, mapopts)
end

M.lspconfig = function()
  local mapopts = { noremap = true, silent = true, }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, mapopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, mapopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, mapopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, mapopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, mapopts)
  vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, mapopts)
  vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, mapopts)
  vim.keymap.set('n', '<Leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, mapopts)
  vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, mapopts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, mapopts)
  vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, mapopts)
  vim.keymap.set('n', '<Leader>f', vim.lsp.buf.format, mapopts)
  vim.keymap.set('n', '<F4>', require('trouble').toggle, mapopts)
end

M.coq = function()
  local mapopts = { silent = true, noremap = true, expr = true }
  vim.keymap.set('i', '<Esc>', function() return vim.fn.pumvisible() == 1 and '<C-e><Esc>' or '<Esc>' end, mapopts)
  vim.keymap.set('i', '<C-c>', function() return vim.fn.pumvisible() == 1 and '<C-e><C-c>' or '<C-c>' end, mapopts)
  vim.keymap.set('i', '<Tab>', function() return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>' end, mapopts)
  vim.keymap.set('i', '<S-Tab>', function() return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>' end, mapopts)
  vim.keymap.set('i', '<CR>',
    function() return vim.fn.pumvisible() == 1 and (vim.fn.complete_info().selected == -1 and '<C-e><CR>' or '<C-y>') or
      '<CR>' end, mapopts)
end

M.gitsigns = function()
  local mapopts = { noremap = true, silent = true, }
  vim.keymap.set('n', '<Leader>hs', function() require('gitsigns').stage_hunk() end, mapopts)
  vim.keymap.set('n', '<Leader>hr', function() require('gitsigns').reset_hunk() end, mapopts)
  vim.keymap.set('v', '<Leader>hs', function() require('gitsigns').stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, mapopts)
  vim.keymap.set('v', '<Leader>hr', function() require('gitsigns').reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, mapopts)
  vim.keymap.set('v', '<Leader>hP', function() require('gitsigns').preview_hunk() end, mapopts)
  vim.keymap.set('v', '<Leader>hn', function() require('gitsigns').next_hunk({ preview = true, }) end, mapopts)
  vim.keymap.set('v', '<Leader>hp', function() require('gitsigns').prev_hunk({ preview = true, }) end, mapopts)
  vim.keymap.set('v', '<Leader>hh', function() require('gitsigns').setloclist() end, mapopts)
  vim.keymap.set('v', '<Leader>hd', function() require('gitsigns').diffthis() end, mapopts)
  vim.keymap.set('v', '<Leader>hb', function() require('gitsigns').toggle_current_line_blame() end, mapopts)
end

M.dap = function()
  local mapopts = { silent = true, noremap = true, }
  vim.keymap.set('n', '<F5>', function() require('dap').continue() end, mapopts)
  vim.keymap.set('n', '<F6>', function() require('dap').step_over() end, mapopts)
  vim.keymap.set('n', '<F7>', function() require('dap').step_into() end, mapopts)
  vim.keymap.set('n', '<F8>', function() require('dap').step_out() end, mapopts)
  vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, mapopts)
end

return M
