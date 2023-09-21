return {
  {
    'williamboman/mason.nvim',
    config = true,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'ray-x/lsp_signature.nvim',
      'neovim/nvim-lspconfig',
      'jackguo380/vim-lsp-cxx-highlight',
    },
    opts = {
      ensure_installed = {
        'bashls',
        'cmake',
        'pylsp',
        'lua_ls',
        'clangd',
      },
    },
    config = function(_, opts)
      local handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup()
        end,
      }
      for _, server in pairs(opts.ensure_installed) do
        handlers[server] = require('plugins.lsp_servers.' .. server)
      end
      require('mason-lspconfig').setup(opts)
      require('mason-lspconfig').setup_handlers(handlers)
    end,
  },
}
