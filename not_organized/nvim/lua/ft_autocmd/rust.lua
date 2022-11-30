vim.api.nvim_create_autocmd(
    'FileType',
    { 
        pattern = { 'rust' }, 
        callback = function()
            vim.api.nvim_buf_set_keymap(0, 'n', '<F9>', ':TermExec cmd="cargo run %"<CR>', { noremap = true, desc = "run rust code on a split toggleterm"})
        end
    }
)
