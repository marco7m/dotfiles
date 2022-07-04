vim.api.nvim_create_autocmd(
    'FileType',
    { 
        pattern = { 'lua' }, 
        callback = function()
            vim.api.nvim_buf_set_keymap(0, 'n', '<F9>', ':TermExec cmd="lua %"<CR><C-w><C-k>', { noremap = true, desc = "run lua code on a split toggleterm"})
        end
    }
)
