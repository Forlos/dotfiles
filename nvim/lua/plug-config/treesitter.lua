local treesitter = require "nvim-treesitter.configs"

treesitter.setup {
    ensure_installed = "all",
    highlight = {enable = true},
    indent = {enable = true},
    rainbow = {
        enable = true,
        extended_mode = false, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines = 2000 -- Do not enable for files with more than, int
    }
}

vim.api.nvim_set_option("foldmethod", "expr")
vim.api.nvim_set_option("foldexpr", "nvim_treesitter#foldexpr()")
