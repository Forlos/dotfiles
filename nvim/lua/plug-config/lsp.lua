require("nvim_utils")

local lsp_config = require "lspconfig"
local lsp_status = require("lsp-status")
local lsp_saga = require "lspsaga"
local lsp_kind = require("lspkind")

local diagnostics = {
    virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●"
    },
    virtual_lines = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = ""
    }
}

vim.diagnostic.config(diagnostics)

lsp_kind.init(
    {
        mode = "symbol_text",
        preset = "codicons"
    }
)
lsp_status.register_progress()

nvim_create_augroups(
    {
        Lightbulb = { "CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()" }
    }
)

lsp_saga.init_lsp_saga {
    use_saga_diagnostic_sign = true,
    diagnostic_header_icon = "   ",
    code_action_icon = " ",
    error_sign = "",
    warn_sign = "",
    hint_sign = "",
    infor_sign = "",
    code_action_keys = {
        quit = { "q", "<esc>" },
        exec = "<CR>"
    },
    rename_action_keys = {
        quit = { "<esc>" },
        exec = "<CR>"
    }
}

-- Python
lsp_config.pyright.setup {
    on_attach = lsp_status.on_attach,
    capabilities = lsp_status.capabilities,
    settings = {
        python = {
            analysis = {
                -- typeCheckingMode = "strict",
                diagnosticMode = "workspace"
            }
        }
    }
}

-- Rust
require("rust-tools").setup(
    {
        tools = {
            runnables = {
                use_telescope = true
            },
            inlay_hints = { auto = true, show_parameter_hints = true, locationLinks = false },
            hover_actions = { auto_focus = true }
        },
        ["rust-analyzer"] = {
            inlayHints = { auto = true, show_parameter_hints = true },
            lens = {
                enable = true
            },
            checkonsave = {
                command = "clippy"
            },
            procMacros = {
                enabled = true
            }
        }
    }
)
--lspconfig.rust_analyzer.setup {
--    on_attach = lsp_status.on_attach,
--    capabilities = lsp_status.capabilities
--}

-- Lua
require "lspconfig".lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT"
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" }
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true)
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false
            }
        }
    }
}

-- Scala
metals_config = require("metals").bare_config()
metals_config.init_options.statusBarProvider = "on"
metals_config.settings = {
    showImplicitArguments = true,
    excludedPackages = {
        "akka.actor.typed.javadsl",
        "com.github.swagger.akka.javadsl"
    }
}
metals_config.on_attach = function()
    require "completion".on_attach()
end

vim.cmd([[augroup lsp]])
vim.cmd([[autocmd!]])
vim.cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
vim.cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(metals_config)]])
vim.cmd([[augroup end]])

-- Go
require "lspconfig".gopls.setup {}
