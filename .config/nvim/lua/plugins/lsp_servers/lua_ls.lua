local M = {}

M.opts = {
    before_init = require("neodev.lsp").before_init,
}

M.setup = function()
    require('lspconfig').lua_ls.setup(require('coq').lsp_ensure_capabilities(M.opts))
end

return M.setup
