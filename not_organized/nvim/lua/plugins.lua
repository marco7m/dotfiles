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

        use { 'rust-lang/rust.vim' }

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

        use { 'akinsho/toggleterm.nvim', tag = '*', config = function() require('plugins.toggleterm') end }

        use {
            'nvim-telescope/telescope.nvim', branch = '0.1.x',
            requires = { {'nvim-lua/plenary.nvim'} },
            config = function() require('plugins.telescope') end
        }

        use {"ellisonleao/glow.nvim", branch = 'main'}

        use {'is0n/fm-nvim', config = function() require('plugins.fm-nvim') end }

        use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

        use { 'doronbehar/nvim-fugitive' }

        -- press K to see the signature
        use { 'ray-x/lsp_signature.nvim', config = function() require "lsp_signature".setup({}) end }

        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup {
                    -- your configuration comes here
                }
            end
        }

        use({
            "seandewar/killersheep.nvim",
            config = function()
                require("killersheep").setup {
                    gore = true,           -- Enables/disables blood and gore.
                    keymaps = {
                        move_left = "h",     -- Keymap to move cannon to the left.
                        move_right = "l",    -- Keymap to move cannon to the right.
                        shoot = "<Space>",   -- Keymap to shoot the cannon.
                    }
                }
            end
        })

        -- use {
        --     'nvim-treesitter/nvim-treesitter',
        --     run = ':TSUpdate'
        -- }
        use {
            'nvim-treesitter/nvim-treesitter',
            run = function()
                local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
                ts_update()
            end,
        }

        use ({
            'tamton-aquib/duck.nvim',
            vim.keymap.set('n', '<leader>dd', function() require("duck").hatch() end, {}),
            vim.keymap.set('n', '<leader>dk', function() require("duck").cook() end, {})
        })

        use 'eandrju/cellular-automaton.nvim' 

        use({
            "iamcco/markdown-preview.nvim",
            run = function() vim.fn["mkdp#util#install"]() end,
        })

        use({
            "dyng/ctrlsf.vim"
        })

        use({'vimwiki/vimwiki',
            config = function() require('plugins.vimwiki') end
        })

        use({'Iron-E/nvim-libmodal'})

        use({
            -- 'marco7m/nvim-test-plugin',
            '~/slapy/programacao/neovim-plugins/nvim-test-plugin',
            wants='nvim-libmodal'
        })
        -- use({'~/slapy/programacao/neovim-plugins/test-conceal'})


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
