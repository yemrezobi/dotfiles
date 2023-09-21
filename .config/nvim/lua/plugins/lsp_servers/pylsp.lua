local M = {}

M.opts = {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'E501'},
        },
      },
    },
  },
}

M.setup = function()
  require('lspconfig').pylsp.setup(require('coq').lsp_ensure_capabilities(M.opts))
end

return M.setup
