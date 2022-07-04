vim.api.nvim_create_autocmd(
    'FileType',
    { 
        pattern = { 'python' }, 
        callback = function()
            vim.api.nvim_buf_set_keymap(0, 'n', '<F9>', ':TermExec cmd="python %"<CR>', { noremap = true, desc = "run python code on a split toggleterm"})
        end
    }
)
