return {
  'lewis6991/gitsigns.nvim',
  lazy = false,
  opts = {
    linehl = true,
    worktrees = {
      {
        toplevel = vim.env.HOME,
        gitdir = vim.env.HOME .. '/dotfiles/.git'
      },
    },
  },
  config = function(_, opts)
    require('gitsigns').setup(opts)
    require('core/keys').gitsigns()
  end,
}
