require("nvim_utils")

vim.api.nvim_set_option("clipboard", "unnamedplus")
vim.api.nvim_set_option("termguicolors", true)
vim.api.nvim_set_option("mouse", "a")
vim.api.nvim_set_option("timeoutlen", 500)
vim.api.nvim_set_option("foldmethod", "manual")
vim.api.nvim_set_option("hidden", true)

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- https://github.com/nanotee/nvim-lua-guide/blob/master/README.md#caveats-3
vim.bo.tabstop = 4
vim.o.tabstop = 4

vim.bo.shiftwidth = 4
vim.o.shiftwidth = 4

vim.bo.expandtab = true
vim.o.expandtab = true

vim.bo.textwidth = 96
vim.o.textwidth = 96

vim.o.completeopt = "menuone,noselect"

vim.wo.relativenumber = true
vim.wo.number = true

vim.wo.foldenable = false

vim.opt_global.shortmess:remove("F")

-- Neovide config
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_cursor_antialiasing = true

vim.o.guifont = "GohuFont Nerd Font"

-- Project,nvim config
vim.g.nvim_tree_update_cwd = 1
vim.g.nvim_tree_respect_buf_cwd = 1

-- Custom filetypes
nvim_create_augroups(
    {
        kaitai_filetype = { " BufNewFile,BufRead *.ksy setf yaml" }
    }
)

vim.g.coq_settings = {
    ["display.preview.positions"] = { ["north"] = 2, ["south"] = 3, ["west"] = 4, ["east"] = 1 },
    ["auto_start"] = true,
    ["keymap.pre_select"] = true
}
