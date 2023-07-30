local treesitter = require "nvim-treesitter.configs"

require("orgmode").setup_ts_grammar()

treesitter.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    indent = {
        enable = true
    },
    rainbow = {
        enable = true,
        extended_mode = false, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines = 3000  -- Do not enable for files with more than, int
    },
    refactor = {
        highlight_definitions = {
            enable = true
        },
        highlight_current_scope = {
            enable = false
        }
    }
}

vim.api.nvim_set_option("foldmethod", "expr")
vim.api.nvim_set_option("foldexpr", "nvim_treesitter#foldexpr()")
