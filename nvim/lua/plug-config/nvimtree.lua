local tree_cb = require "nvim-tree.config".nvim_tree_callback

vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_ignore = {".git"}

vim.g.nvim_tree_bindings = {
    ["<CR>"] = tree_cb("edit"),
    ["<C-]>"] = tree_cb("cd"),
    ["m"] = tree_cb("cd"),
    ["<Tab>"] = tree_cb("toggle_node"),
    ["I"] = tree_cb("toggle_ignored"),
    ["H"] = tree_cb("toggle_dotfiles"),
    ["R"] = tree_cb("refresh"),
    ["c"] = tree_cb("create"),
    ["d"] = tree_cb("remove"),
    ["r"] = tree_cb("rename"),
    ["<C-r>"] = tree_cb("full_rename"),
    ["-"] = tree_cb("dir_up"),
    ["q"] = tree_cb("close")
}
