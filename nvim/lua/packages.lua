vim.cmd [[packadd packer.nvim]]

return require("packer").startup(
    function()
        -- Packer
        use {"wbthomason/packer.nvim", opt = true}

        -- Syntax
        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
        use {"p00f/nvim-ts-rainbow"}
        use {"nvim-treesitter/nvim-treesitter-refactor"}

        -- Theme
        use {
            "hoob3rt/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons", opt = true}
        }
        use {"folke/tokyonight.nvim"}
        use {"kyazdani42/nvim-tree.lua", requires = {"kyazdani42/nvim-web-devicons"}}
        use {"folke/todo-comments.nvim", requires = {"nvim-lua/plenary.nvim"}}
        use {"glepnir/dashboard-nvim"}

        -- Lsp
        use {"neovim/nvim-lspconfig"}
        use {"nvim-lua/lsp-status.nvim"}
        use {"folke/lsp-trouble.nvim", requires = {"kyazdani42/nvim-web-devicons"}}
        use {
            "simrat39/rust-tools.nvim",
            requires = {
                "nvim-lua/popup.nvim",
                "nvim-lua/plenary.nvim"
            }
        }
        use {"hrsh7th/nvim-compe", requires = {"hrsh7th/vim-vsnip"}}
        use {"kosayoda/nvim-lightbulb"}
        use {"glepnir/lspsaga.nvim"}
        use {"onsails/lspkind-nvim"}
        use {"ahmedkhalf/lsp-rooter.nvim"}

        -- Format
        use {"lukas-reineke/format.nvim"}
        use {"b3nj5m1n/kommentary"}
        use {"jiangmiao/auto-pairs"}

        -- Geneal Tools
        use {"tweekmonster/startuptime.vim"}
        use {"folke/which-key.nvim"}
        use {
            "nvim-telescope/telescope.nvim",
            requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
        }
        use {"nvim-telescope/telescope-media-files.nvim"}
        use {
            "sudormrfbin/cheatsheet.nvim",
            requires = {
                {"nvim-telescope/telescope.nvim"},
                {"nvim-lua/popup.nvim"},
                {"nvim-lua/plenary.nvim"}
            }
        }

        -- Git
        use {"lewis6991/gitsigns.nvim", requires = {"nvim-lua/plenary.nvim"}}
        use {"TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim"}

        -- Utils
        use {"norcalli/nvim_utils"}
        use {"famiu/nvim-reload"}
        use {
            "folke/zen-mode.nvim",
            config = function()
                require("zen-mode").setup {}
            end
        }
        use {"akinsho/nvim-toggleterm.lua"}
        use {"famiu/bufdelete.nvim"}

        -- Org
        --[[ use {
            "vhyrro/neorg",
            branch = "unstable",
            config = function()
                require("neorg").setup {}
            end
        } ]]
        use {
            "kristijanhusak/orgmode.nvim",
            config = function()
                require("orgmode").setup {}
            end
        }
    end
)
