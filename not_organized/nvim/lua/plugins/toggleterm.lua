require("toggleterm").setup()

vim.api.nvim_set_keymap('n', '<F10>', ':ToggleTerm<CR>', { noremap = true, desc = "Toggle terminal"})

function _G.set_terminal_keymaps()
    vim.api.nvim_set_keymap('t', '<F10>', '<C-\\><C-n><C-w><C-p>:ToggleTerm<CR>', { noremap = true})
    -- vim.api.nvim_set_keymap('t', 'jk', '<C-\><C-n><C-w><C-p>', { noremap = true, desc = "movimentação entre windows"})
    vim.api.nvim_set_keymap('t', '<M-h>', '<C-\\><C-n><C-W>h', { noremap = true})
    vim.api.nvim_set_keymap('t', '<M-j>', '<C-\\><C-n><C-W>j', { noremap = true})
    vim.api.nvim_set_keymap('t', '<M-k>', '<C-\\><C-n><C-W>k', { noremap = true})
    vim.api.nvim_set_keymap('t', '<M-l>', '<C-\\><C-n><C-W>l', { noremap = true})
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require('toggleterm.terminal').Terminal
local meuterm = Terminal:new({ cmd = "git f; git lg", hidden = true, direction = 'float', border = 'curved', start_in_insert = false})
function meuterm_toggle()
    meuterm:toggle()
end
vim.api.nvim_set_keymap('n', '<F3>', '<cmd>lua meuterm_toggle()<CR>', { noremap = true, desc = "Toggle terminal"})
