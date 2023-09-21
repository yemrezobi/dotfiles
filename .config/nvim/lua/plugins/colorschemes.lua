return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'storm',
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd.colorscheme('tokyonight')
    end,
  },
  {
    'chriskempson/tomorrow-theme',
    config = function(plugin, opts)
      vim.opt.rtp:append(plugin.dir .. "/vim")
    end,
  },
}
