return {
    "preservim/tagbar",
    cmd = "TagbarToggle",
    config = function()
        -- Configuração do tagbar
        vim.g.tagbar_width = 30
        vim.g.tagbar_autofocus = 1
        vim.g.tagbar_sort = 0 -- Mantém a ordem original dos símbolos

        -- Atalho para abrir/fechar o tagbar
        -- vim.keymap.set("n", "<F8>", ":TagbarToggle<CR>", { noremap = true, silent = true, desc = "Toggle Tagbar" })
    end
}
