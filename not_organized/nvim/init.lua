--vim.keymap.set("n", "lhs", vim.ui.input({ prompt = 'Enter value for shiftwidth: '}, function(input) vim.o.shiftwidth = tonumber(input) end))

require('plugins')
require('mappings')
require('scripts')
require('ft_autocmd')


-- não sei onde por isso e nem oq faz
vim.opt.termguicolors = true

local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.setup()
