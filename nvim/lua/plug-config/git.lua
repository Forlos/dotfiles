local neogit = require("neogit")

neogit.setup {
    auto_refresh = true,
    integrations = {
        diffview = true
    }
}
neogit.config.use_magit_keybindings()

require("gitsigns").setup {
    signs = {
        add = {hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn"},
        change = {hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"},
        delete = {hl = "GitSignsDelete", text = "-", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"},
        topdelete = {hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"},
        changedelete = {hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"}
    },
    numhl = true,
    linehl = false,
    keymaps = {},
    watch_index = {
        interval = 1000
    },
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 500,
        ignore_whitespace = false
    },
    current_line_blame_formatter_opts = {
        relative_time = false
    },
    sign_priority = 1,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    use_decoration_api = true,
    use_internal_diff = true -- If luajit is present
}
