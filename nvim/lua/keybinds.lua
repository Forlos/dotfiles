vim.g.mapleader = " "

-- Window manipulation
vim.api.nvim_set_keymap("n", "<Leader>w", "<C-W>", {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>wd", "<Cmd>:q<CR>", {noremap = true})

vim.api.nvim_set_keymap("n", "<Leader>w/", "<Cmd>:vsplit<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>w-", "<Cmd>:split<CR>", {noremap = true})

-- Files
vim.api.nvim_set_keymap("n", "<Leader>fs", "<Cmd>:w<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>fS", ":w ", {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>fd", "<cmd>Telescope file_browser<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>fr", "<cmd>Telescope oldfiles<cr>", {noremap = true})

--- Buffer
vim.api.nvim_set_keymap("n", "<Leader>bb", "<cmd>Telescope buffers<cr>", {noremap = true})

-- Search
vim.api.nvim_set_keymap("n", "<Leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>sp", "<cmd>Telescope live_grep<cr>", {noremap = true})

-- Project
vim.api.nvim_set_keymap("n", "<Leader>pf", "<cmd>Telescope find_files<cr>", {noremap = true})

-- Exit
vim.api.nvim_set_keymap("n", "<Leader>qq", "<Cmd>:conf qa<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>qQ", "<Cmd>:qa!<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>qr", "<Cmd>:Restart<CR>", {noremap = true})

-- Lsp
vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", {noremap = true, silent = true, expr = true})
vim.api.nvim_set_keymap("n", "<leader>cf", "<cmd>LspTroubleToggle<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap(
    "n",
    "<leader>cx",
    "<cmd>Telescope lsp_workspace_diagnostics<cr>",
    {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>cd", "<cmd>Telescope lsp_definitions<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>cD", "<cmd>Telescope lsp_references<cr>", {silent = true, noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>cr", "<cmd>Lspsaga rename<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", {silent = true, noremap = true})

-- Nvim tree
vim.api.nvim_set_keymap("n", "<Leader>op", "<Cmd>:NvimTreeToggle<CR>", {noremap = true})

-- Help
vim.api.nvim_set_keymap("n", "<Leader>sv", "<cmd>Telescope vim_options<cr>", {noremap = true})

-- Global
vim.api.nvim_set_keymap("n", "<Leader><Leader>", "<cmd>Telescope commands<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>'", "<cmd>Lspsaga open_floaterm<cr>", {noremap = true})

-- Git
vim.api.nvim_set_keymap("n", "<Leader>gg", "<cmd>Neogit<cr>", {noremap = true})
