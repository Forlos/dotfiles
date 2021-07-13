require("nvim_utils")

vim.api.nvim_set_option("clipboard", "unnamedplus")
vim.api.nvim_set_option("termguicolors", true)
vim.api.nvim_set_option("mouse", "a")
vim.api.nvim_set_option("timeoutlen", 500)
vim.api.nvim_set_option("foldmethod", "manual")
vim.api.nvim_set_option("hidden", true)

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

-- Neovide config
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_cursor_antialiasing = true

vim.o.guifont = "GohuFont Nerd Font"

-- Custom filetypes
nvim_create_augroups(
    {
        kaitai_filetype = {" BufNewFile,BufRead *.ksy setf yaml"}
    }
)
