require("nvim_utils")

-- Formating on save
nvim_create_augroups(
    {
        FormatAutogroup = { "BufWritePost * FormatWriteLock" },
        LspFormat = { "BufWritePre * lua vim.lsp.buf.format()" }
    }
)

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
        lua = {
            require("formatter.filetypes.lua").luafmt()
        },
        go = {
            require("formatter.filetypes.go").gofmt(),
            require("formatter.filetypes.go").goimports()
        },
        python = {
            require("formatter.filetypes.python").black()
        },
        typescript = {
            require("formatter.filetypes.typescript").prettier()
        },
        typescriptreact = {
            require("formatter.filetypes.typescriptreact").prettier()
        },
        ["*"] = {
            {
                exe = "sed",
                args = { "'s/[ \t]*$//'" },
                stdin = true
            }
        }
    }
}
