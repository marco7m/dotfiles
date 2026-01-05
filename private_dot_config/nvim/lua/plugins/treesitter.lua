return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag", -- Auto fechamento de tags em HTML/JSX
    },
    config = function()
        local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

        -- Parser customizado para Norg
        parser_configs.norg = {
            install_info = {
                url = "https://github.com/vhyrro/tree-sitter-norg",
                files = { "src/parser.c" },
                branch = "main",
            },
        }

        require("nvim-treesitter.configs").setup({
            ensure_installed = "all", -- Instala todos os parsers disponíveis
            auto_install = true, -- Instala automaticamente parsers ausentes
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true }, -- Melhora indentação automática
            autotag = { enable = true }, -- Fecha tags automaticamente (HTML, JSX)

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
            },
        })
    end,
}
