local tree_cb = require "nvim-tree.config".nvim_tree_callback

require "nvim-tree".setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    auto_close = false,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = false,
    update_to_buf_dir = {
        enable = true,
        auto_open = true
    },
    diagnostics = {
        enable = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = ""
        }
    },
    update_focused_file = {
        enable = false,
        update_cwd = false,
        ignore_list = {}
    },
    system_open = {
        cmd = nil,
        args = {}
    },
    filters = {
        dotfiles = false,
        custom = {".git"}
    },
    view = {
        width = 40,
        height = 30,
        hide_root_folder = false,
        side = "left",
        auto_resize = false,
        mappings = {
            custom_only = false,
            list = {
                {key = {"<CR>"}, cb = tree_cb("edit")},
                {key = {"<C-}>"}, cb = tree_cb("cd")},
                {key = {"m"}, cb = tree_cb("cd")},
                {key = {"<Tab>"}, cb = tree_cb("toggle_node")},
                {key = {"I"}, cb = tree_cb("toggle_ignored")},
                {key = {"H"}, cb = tree_cb("toggle_dotfiles")},
                {key = {"R"}, cb = tree_cb("refresh")},
                {key = {"c"}, cb = tree_cb("create")},
                {key = {"d"}, cb = tree_cb("remove")},
                {key = {"r"}, cb = tree_cb("rename")},
                {key = {"<C-r>"}, cb = tree_cb("full_rename")},
                {key = {"-"}, cb = tree_cb("dir_up")},
                {key = {"q"}, cb = tree_cb("close")}
            }
        }
    }
}
