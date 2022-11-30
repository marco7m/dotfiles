vim.api.nvim_create_autocmd(
    'FileType',
    { 
        pattern = { 'markdown'}, 
        callback = function()
            -- vim.api.nvim_buf_set_keymap(0, 'n', '<F9>', ':vs term://glow %<CR>', { noremap = true, desc = "open glow on a vsplit tab"})
            vim.api.nvim_buf_set_keymap(0, 'n', '<F9>', ':MarkdownPreviewToggle<CR>', { noremap = true, desc = "open glow on a vsplit tab"})
        end
    }
)
