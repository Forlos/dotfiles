require("nvim_utils")

local lsp_config = require "lspconfig"
local lsp_status = require("lsp-status")
local lsp_saga = require "lspsaga"
local lsp_kind = require("lspkind")

lsp_kind.init(
    {
        mode = 'symbol_text',
        preset = "codicons"
    }
)
lsp_status.register_progress()

nvim_create_augroups(
    {
        Lightbulb = {"CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()"}
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
        quit = {"q", "<esc>"},
        exec = "<CR>"
    },
    rename_action_keys = {
        quit = {"<esc>"},
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
local opts = {
    tools = {
        -- rust-tools options
        -- automatically set inlay hints (type hints)
        -- There is an issue due to which the hints are not applied on the first
        -- opened file. For now, write to the file to trigger a reapplication of
        -- the hints or just run :RustSetInlayHints.
        -- default: true
        autoSetHints = true,
        -- whether to show hover actions inside the hover window
        -- this overrides the default hover handler so something like lspsaga.nvim's hover would be overriden by this
        -- default: true
        hover_with_actions = false,
        -- All opts that go into inlay hints (scroll down a bit) can also go here,
        -- these apply to the default RustSetInlayHints command
        inlay_hints = {
            -- wheter to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = false,
            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "<-",
            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix = "=> "
        },
        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
                {"╭", "FloatBorder"},
                {"─", "FloatBorder"},
                {"╮", "FloatBorder"},
                {"│", "FloatBorder"},
                {"╯", "FloatBorder"},
                {"─", "FloatBorder"},
                {"╰", "FloatBorder"},
                {"│", "FloatBorder"}
            }
        }
    },
    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    --
    server = {
        on_attach = lsp_status.on_attach,
        capabilities = lsp_status.capabilities
    }
}

require("rust-tools").setup(opts)
--lspconfig.rust_analyzer.setup {
--    on_attach = lsp_status.on_attach,
--    capabilities = lsp_status.capabilities
--}

-- Lua
require'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
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
