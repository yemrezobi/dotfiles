return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            {
              'windwp/nvim-ts-autotag',
              config = true,
            }
        },
        main = 'nvim-treesitter.configs',
        opts = {
            ensure_installed = {
                'python',
                'lua',
                'xml',
            },
            sync_install = false,
            auto_install = true,
            autotag = {
                enable = true,
            },
            highlight = {
                enable = true,
                disable = {
                    'cpp',
                },
                additional_vim_regex_highlighting = false,
            },
        },
        build = function()
            print(require('nvim-treesitter.install').update({ with_sync = true }))
        end,
    }
}
