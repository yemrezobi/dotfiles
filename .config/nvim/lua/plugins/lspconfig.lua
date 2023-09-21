return {
  {
    'folke/neodev.nvim',
    opts = {
      override = false,
    },
  },
  {
    'ray-x/lsp_signature.nvim',
    opts = {
      select_signature_key = '<C-E>',
      toggle_key = '<C-H>',
      floating_window = false,
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'ms-jpq/coq_nvim',
      'folke/trouble.nvim',
    },
    event = 'BufReadPre',
    config = function()
      require('core/keys').lspconfig()
    end,
  },
}
