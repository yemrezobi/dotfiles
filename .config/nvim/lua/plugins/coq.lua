return {
    'ms-jpq/coq_nvim',
    dependencies = {
        'ms-jpq/coq.artifacts',
        'altermo/ultimate-autopair.nvim',
    },
    build = ':COQdeps',
    init = function()
        vim.g.coq_settings = {
            auto_start = 'shut-up',
            keymap = {
                recommended = false
            },
            limits = {
                completion_auto_timeout = 0.5
            },
            clients = {
                tree_sitter = {
                    enabled = false,
                },
            },
        }
    end,
    config = function()
        require('core/keys').coq()
    end,
}
