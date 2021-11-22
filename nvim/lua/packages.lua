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
        use {"kosayoda/nvim-lightbulb"}
        use {"tami5/lspsaga.nvim", branch = "nvim51"}
        use {"onsails/lspkind-nvim"}
        use {
            "ahmedkhalf/project.nvim",
            config = function()
                require("project_nvim").setup {}
            end
        }
        use {"scalameta/nvim-metals"}

        -- Completion
        --[[ use {
            "hrsh7th/nvim-cmp",
            requires = {
                "hrsh7th/vim-vsnip",
                "hrsh7th/cmp-buffer"
            }
        } ]]
        use {"ms-jpq/coq_nvim", branch = "coq"}

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
        use {
            "luukvbaal/stabilize.nvim",
            config = function()
                require("stabilize").setup()
            end
        }

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

        -- Neovim in browser
        use {
            "glacambre/firenvim",
            run = function()
                vim.fn["firenvim#install"](0)
            end
        }
    end
)
