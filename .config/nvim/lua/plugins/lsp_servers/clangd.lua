local M = {}

M.opts = {
  init_options = {
      highlight = {
          lsRanges = true,
      }
  },
}

M.setup = function()
  require('lspconfig').clangd.setup(require('coq').lsp_ensure_capabilities(M.opts))
  vim.keymap.set('n', 'gh', '<Cmd>ClangdSwitchSourceHeader<CR>', { noremap = true, silent = true })
end

return M.setup
