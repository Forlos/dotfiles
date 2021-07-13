require("nvim_utils")

-- Formating on save
nvim_create_augroups(
    {
        Format = {"BufWritePost * FormatWrite"},
        LspFormat = {"BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)"}
    }
)

-- Define what files to format on save
require "format".setup {
    ["*"] = {
        {cmd = {"sed -i 's/[ \t]*$//'"}} -- remove trailing whitespace
    },
    vim = {
        {
            cmd = {"luafmt -w replace"},
            start_pattern = "^lua << EOF$",
            end_pattern = "^EOF$"
        }
    },
    lua = {
        {
            cmd = {
                function(file)
                    return string.format("luafmt -w replace %s", file)
                end
            }
        }
    },
    go = {
        {
            cmd = {"gofmt -w", "goimports -w"},
            tempfile_postfix = ".tmp"
        }
    },
    python = {
        {
            cmd = {"black"}
        }
    }
}
