return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'debugloop/telescope-undo.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  event = 'VeryLazy',
  opts = {
    extensions = {
      undo = {
        use_delta = true,
        side_by_side = true,
        diff_context_lines = 20,
        layout_strategy = "flex",
      },
    },
    pickers = {
      colorscheme = {
        enable_preview = true,
      },
    },
  },
  config = function(_, opts)
    local telescope = require('telescope')
    require('core/keys').telescope()
    telescope.setup(opts)
    telescope.load_extension('fzf')
    telescope.load_extension('undo')
  end,
}
