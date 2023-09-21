local M = {}

M.opts = {
  filetypes = {
    'bash',
    'sh',
    'zsh',
  },
}

M.setup = function()
  require('lspconfig').bashls.setup(require('coq').lsp_ensure_capabilities(M.opts))
end

return M.setup
