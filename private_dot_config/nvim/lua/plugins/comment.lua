return {
    "numToStr/Comment.nvim",
    event = "VeryLazy", -- Carrega o plugin apenas quando necessário
    config = function()
        require("Comment").setup({
            -- Configuração opcional
            padding = true, -- Adiciona espaço após o caractere de comentário
            sticky = true, -- Mantém o cursor na posição após comentar
            mappings = {
                basic = true, -- Ativa mapeamentos básicos
                extra = false, -- Desativa mapeamentos extras
            },
        })
    end,
}
