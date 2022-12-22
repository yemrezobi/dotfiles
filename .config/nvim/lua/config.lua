vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "

local on_attach = function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)
end

local lsp = require'lspconfig'
local coq = require'coq'
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

-- nvim-tree --

require('nvim-tree').setup{
    open_on_setup = true,
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

require('trouble').setup()

-- nvim-autopairs --

require('nvim-autopairs').setup()
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

npairs.setup({ map_bs = false, map_cr = false })

vim.g.coq_settings = { keymap = { recommended = false } }

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })

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
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

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
    select_signature_key = '<C-e>',
})
