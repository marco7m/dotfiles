local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')
local util = require'packer.util'
local packer = require("packer")
packer.init({
    package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

--- startup and add configure plugins
packer.startup({
    function(use)
        -- use {'lewis6991/impatient.nvim', config = [[require('impatient')]]}

        use 'wbthomason/packer.nvim'

        -- use {'kyazdani42/nvim-web-devicons'}

        -- use 'nvim-lua/completion-nvim'

        use {
            "kyazdani42/nvim-tree.lua",
            requires = { "kyazdani42/nvim-web-devicons", },
            config = function() require('plugins.nvim-tree') end
        }

        use {
            'numToStr/Comment.nvim',
            config = function() require('Comment').setup() end
        }


        use {
            'VonHeikemen/lsp-zero.nvim',
            requires = {
                -- LSP Support
                {'neovim/nvim-lspconfig'},
                {'williamboman/nvim-lsp-installer'},

                -- Autocompletion
                {'hrsh7th/nvim-cmp'},
                {'hrsh7th/cmp-buffer'},
                {'hrsh7th/cmp-path'},
                {'saadparwaiz1/cmp_luasnip'},
                {'hrsh7th/cmp-nvim-lsp'},
                {'hrsh7th/cmp-nvim-lua'},

                -- Snippets
                {'L3MON4D3/LuaSnip'},
                {'rafamadriz/friendly-snippets'},
            }
        }
        -- -- use { 'williamboman/nvim-lsp-installer', config = function() require('plugins.nvim-lsp-installer') end }
        -- use { 'neovim/nvim-lspconfig', config = function() require('plugins.lspconfig') end }
        -- use { 'ms-jpq/coq_nvim', branch = 'coq', run = 'python3 -m coq deps', config = function() require('plugins.coq_nvim') end }
        -- use { 'ms-jpq/coq.artifacts', branch = 'artifacts'}

        use { 'preservim/tagbar', config = function() require('plugins.tagbar') end }

        use { 'akinsho/toggleterm.nvim', tag = 'v1.*', config = function() require('plugins.toggleterm') end }

        use {
            'nvim-telescope/telescope.nvim',
            requires = { {'nvim-lua/plenary.nvim'} },
            config = function() require('plugins.telescope') end
        }

        use {"ellisonleao/glow.nvim", branch = 'main'}

        use {'is0n/fm-nvim', config = function() require('plugins.fm-nvim') end }

        use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

        use { 'doronbehar/nvim-fugitive' }

        -- use {
        --     "nvim-neorg/neorg",
        --     config = function() require('plugins.neorg') end,
        --     requires = "nvim-lua/plenary.nvim"
        -- }

        -- use {
        --     'nvim-treesitter/nvim-treesitter',
        --     config = function() require('plugins.treesitter') end,
        --     runt = ':TSUpdate'
        -- }
        -- -- colorbuddy allows us to run the gloombuddy theme
        -- use 'tjdevries/colorbuddy.nvim'
        -- use 'bkegley/gloombuddy'

        -- use {"nanotech/jellybeans.vim", config = [[ vim.cmd("colorscheme jellybeans") ]] }
        use { "EdenEast/nightfox.nvim", tag = "v1.0.0", config = [[ vim.cmd("colorscheme nightfox") ]] }
    end,
    config = {
        max_jobs = 16,
        compile_path = util.join_paths(fn.stdpath('data'), 'site', 'lua', 'packer_compiled.lua'),
    },
})

local status, _ = pcall(require, 'packer_compiled')
if not status then
    vim.notify("Error requiring packer_compiled.lua: run PackerSync to fix!")
end
