return {
    {
        "EdenEast/nightfox.nvim",
        version = "v1.0.0", -- Define a versão específica do tema
        lazy = false,   -- Garante que o tema seja carregado imediatamente
        priority = 1000, -- Faz o carregamento do tema antes de outros plugins
        config = function()
            vim.cmd("colorscheme nightfox")
        end,
    }
}
