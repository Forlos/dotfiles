local tree_cb = require "nvim-tree.config".nvim_tree_callback

vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_ignore = {".git"}

vim.g.nvim_tree_bindings = {
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
