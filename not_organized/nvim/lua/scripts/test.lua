function test1()
    local line = vim.fn.getline(1)
    vim.fn.setline(2, line)
end
vim.api.nvim_set_keymap('n', 'ttt', '', { noremap = true, callback= test1, desc = "test1"})
