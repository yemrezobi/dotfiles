vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.coq_settings = { auto_start = 'shut-up' }
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.airline_powerline_fonts = 1
vim.o.tabstop = 4
vim.o.shiftwidth = vim.o.tabstop
vim.o.expandtab = true
vim.o.number = true
vim.o.mouse = false
vim.o.termguicolors = true
-- highlight whitespace at end of lines
vim.fn.matchadd('errorMsg', [[\s\+$]])

local mapopts = { silent=true, noremap=true }
-- Esc to clear search highlighting
vim.keymap.set('n', '<Esc>'  , '<Cmd>noh<CR>', mapopts)
-- vim-devdocs
vim.keymap.set('n', 'H'      , '<Cmd>DD<CR>' , mapopts)
-- j and k simultaneously to exit insert mode
vim.keymap.set('i', 'jk'     , '<Esc>'       , mapopts)
vim.keymap.set('i', 'kj'     , '<Esc>'       , mapopts)
-- CR to insert line below, C-CR to insert line above cursor
vim.keymap.set('n', '<Enter>', 'o<Esc>'      , mapopts)
vim.keymap.set('n', '<NL>'   , 'O<Esc>'      , mapopts)

-- coq --

local coq = require'coq'

vim.g.coq_settings = {
    keymap = { recommended = false },
    limits = { completion_auto_timeout = 0.1 },
}

vim.keymap.set('i', '<Esc>', function()
    return vim.fn.pumvisible() == 1 and "<C-e><Esc>" or "<Esc>"
end, { expr = true, noremap = true })

vim.keymap.set('i', '<C-c>', function()
    return vim.fn.pumvisible() == 1 and "<C-e><C-c>" or "<C-c>"
end, { expr = true, noremap = true })

vim.keymap.set('i', '<Tab>', function()
    return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true, noremap = true })

vim.keymap.set('i', '<S-Tab>', function()
    return vim.fn.pumvisible() == 1 and "<C-p>" or "<Bs>"
end, { expr = true, noremap = true })

-- lsp --

local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD'        , vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd'        , vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K'         , vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi'        , vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>'     , vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<Leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<Leader>D' , vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr'        , "<cmd>TroubleToggle lsp_references<CR>", bufopts)
  vim.keymap.set('n', '<Leader>f' , vim.lsp.buf.format, bufopts)
end

local lsp = require'lspconfig'
lsp.bashls.setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
}))
lsp.cmake.setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
}))
lsp.pylsp.setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = {'E501'},
                }
            }
        }
    }
}))

-- trouble.nvim --

require('trouble').setup()

-- nvim-tree --

require('nvim-tree').setup{
    open_on_tab = true,
    hijack_cursor = true,
    update_focused_file = {
        enable = true,
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
    },
    git = {
        ignore = false
    },
    view = {
        width = '15%',
    },
    renderer = {
        add_trailing = true,
        group_empty = true,
        highlight_git = true,
        highlight_opened_files = all,
        indent_markers = {
            enable = true,
        },
        icons = {
            git_placement = 'after',
        },
    },
}
vim.keymap.set('n', '<F3>', require('nvim-tree.api').tree.toggle, { noremap = true, silent = true })

-- nvim-autopairs --

local npairs = require('nvim-autopairs')

npairs.setup({
    map_bs = false,
    map_cr = false,
    fast_wrap = {},
})

---- the following is for coq from the nvim-autopairs README
_G.MUtils= {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<C-Y>')
    else
      return npairs.esc('<C-E>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<C-E>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
vim.api.nvim_set_keymap('i', '<BS>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })

---- spaces in parantheses

local Rule = require'nvim-autopairs.rule'
local cond = require'nvim-autopairs.conds'
local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function(opts)
      local pair = opts.line:sub(opts.col -1, opts.col)
      return vim.tbl_contains({
        brackets[1][1]..brackets[1][2],
        brackets[2][1]..brackets[2][2],
        brackets[3][1]..brackets[3][2]
      }, pair)
    end)
    :with_move(cond.none())
    :with_cr(cond.none())
    :with_del(function(opts)
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local context = opts.line:sub(col - 1, col + 2)
      return vim.tbl_contains({
        brackets[1][1]..'  '..brackets[1][2],
        brackets[2][1]..'  '..brackets[2][2],
        brackets[3][1]..'  '..brackets[3][2]
      }, context)
    end)
}
for _,bracket in pairs(brackets) do
  Rule('', ' '..bracket[2])
    :with_pair(cond.none())
    :with_move(function(opts) return opts.char == bracket[2] end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key(bracket[2])
end

-- nvim-treesitter --

--autotag will break if parser is removed
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.html.filetype = { 'html', 'xml', }

local ft_to_parser = require('nvim-treesitter.parsers').filetype_to_parsername
ft_to_parser.xml = 'html'

require('nvim-treesitter.configs').setup{
    ensure_installed = { python, lua, html },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        disable = { 'cpp', 'html', },
        additional_vim_regex_highlighting = false,
    },
}

-- telescope --

require('telescope').setup()

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<Leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<Leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<Leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<Leader>fh', builtin.help_tags, {})

-- nvim-lsp-cxx-highlight --

lsp.clangd.setup{
  init_options = {
    highlight = {
      lsRanges = true;
    }
  },
  on_attach=on_attach,
}

-- nvim-ts-autotag --

require('nvim-ts-autotag').setup()

-- lsp-signature.nvim --

require'lsp_signature'.setup({
    select_signature_key = '<C-E>',
})
