require("nvim_utils")

local lsp_config = require "lspconfig"
local lsp_status = require("lsp-status")
local lsp_trouble = require("trouble")
local lsp_saga = require "lspsaga"
local lsp_kind = require("lspkind")

lsp_kind.init(
    {
        -- enables text annotations
        --
        -- default: true
        with_text = true,
        -- default symbol map
        -- can be either 'default' (requires nerd-fonts font) or
        -- 'codicons' for codicon preset (requires vscode-codicons font)
        --
        -- default: 'default'
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
    dianostic_header_icon = "   ",
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

-- Lsp trouble config
lsp_trouble.setup {
    height = 10, -- height of the trouble list
    icons = true, -- use devicons for filenames
    mode = "lsp_workspace_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    action_keys = {
        -- key mappings for actions in the trouble list
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small poup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "k", -- preview item
        next = "j" -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatyically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠"
    },
    use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
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
local sumneko_root_path = vim.fn.stdpath("cache") .. "/lspconfig/sumneko_lua/lua-language-server"
local sumneko_binary = "lua-language-server"
lsp_config.sumneko_lua.setup {
    on_attach = lsp_status.on_attach,
    capabilities = lsp_status.capabilities,
    cmd = {
        sumneko_binary,
        "-E",
        sumneko_root_path .. "/main.lua"
    },
    settings = {
        Lua = {
            telemetry = {
                enable = false
            },
            diagnostics = {
                globals = {
                    "vim",
                    "use"
                }
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                },
                maxPreload = 10000
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
