return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "Telescope",
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>",           desc = "Buscar arquivos" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>",            desc = "Buscar conteúdo nos arquivos" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>",              desc = "Buscar buffers abertos" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",            desc = "Buscar ajuda do Neovim" },
            { "<leader>fs", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Buscar funções/variáveis no arquivo atual" },
            { "<leader>fw", "<cmd>Telescope grep_string<cr>",          desc = "Buscar palavra sob o cursor" },
        },
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = { "node_modules", ".git/" }, -- Ignorar pastas desnecessárias
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- Correção aqui
                        },
                    },
                },
            })
        end,
    },

    -- Plugin para acelerar buscas com FZF
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("telescope").load_extension("fzf")
        end
    }
}
