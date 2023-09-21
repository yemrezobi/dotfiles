return {
  {
    'kylechui/nvim-surround',
    event = "VeryLazy",
    opts = {},
  },
  {
    'stevearc/dressing.nvim',
  },
  {
    'altermo/ultimate-autopair.nvim',
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6',
    opts = {},
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    opts = {
      theme = 'horizon',
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    opts = {
      show_current_context = true,
      show_current_context_start = true,
    },
  },
}
