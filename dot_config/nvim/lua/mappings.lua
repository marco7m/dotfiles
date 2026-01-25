
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, desc = "diagnostico de linha" })

vim.api.nvim_set_keymap('n', '<F8>', ':nohl<CR>', { noremap = true, desc = "press F8 to turn the search results highlight off"})
vim.api.nvim_set_keymap('i', 'jk', '<esc>', { noremap = true, desc = "faz ter que digitar jk para sair do insert mode"})
vim.api.nvim_set_keymap('i', 'JK', '<esc>', { noremap = true, desc = "faz ter que digitar JK para sair do insert mode"})
vim.api.nvim_set_keymap('n', '<space>', ':', { noremap = true, desc = "faz a barra de espaço colocar :"})

vim.api.nvim_set_keymap('n', '<M-l>', '<C-w>l', { noremap = true, desc = "movimentação entre windows"})
vim.api.nvim_set_keymap('n', '<M-j>', '<C-w>j', { noremap = true, desc = "movimentação entre windows"})
vim.api.nvim_set_keymap('n', '<M-h>', '<C-w>h', { noremap = true, desc = "movimentação entre windows"})
vim.api.nvim_set_keymap('n', '<M-k>', '<C-w>k', { noremap = true, desc = "movimentação entre windows"})
vim.api.nvim_set_keymap('t', '<M-l>', '<C-w>l', { noremap = true, desc = "movimentação entre windows"})
vim.api.nvim_set_keymap('t', '<M-j>', '<C-w>j', { noremap = true, desc = "movimentação entre windows"})
vim.api.nvim_set_keymap('t', '<M-h>', '<C-w>h', { noremap = true, desc = "movimentação entre windows"})
vim.api.nvim_set_keymap('t', '<M-k>', '<C-w>k', { noremap = true, desc = "movimentação entre windows"})




