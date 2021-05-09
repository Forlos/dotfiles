-- Bootstrap nvim installation
require("bootstrap")

require("keybinds")
require("settings")
require("packages")
require("theme")

require("plug-config")

vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]
