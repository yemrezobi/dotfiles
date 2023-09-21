return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    '<F3>',
  },
  opts = {
    open_on_tab = true,
    hijack_cursor = true,
    update_focused_file = {
      enable = true,
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    git = {
      ignore = false
    },
    view = {
      width = '20%',
    },
    renderer = {
      add_trailing = true,
      group_empty = true,
      highlight_git = true,
      highlight_opened_files = 'all',
      indent_markers = {
        enable = true,
      },
      icons = {
        git_placement = 'after',
      },
    },
  },
  config = function(_, opts)
    vim.keymap.set('n', '<F3>', require('nvim-tree.api').tree.toggle, { noremap = true, silent = true })
    require('nvim-tree').setup(opts)
  end,
}
