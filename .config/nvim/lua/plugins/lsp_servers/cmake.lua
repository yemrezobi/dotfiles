local M = {}

M.opts = {
  settings = {
    filetypes = {
      "cmake",
      "CMakeFiles.txt",
    },
  },
}

M.setup = function()
  require('lspconfig').cmake.setup(require('coq').lsp_ensure_capabilities(M.opts))
end

return M.setup
