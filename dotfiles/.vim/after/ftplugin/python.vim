"easy compile
nnoremap <F9> :!python % <cr>

nnoremap <leader>p aprint(""<ESC>Pf"i: <ESC>f"a, )<ESC>P
inoremap <leader>p print(""<ESC>Pf"i: <ESC>f"a, )<ESC>P

" configuration for python-mode plugin
" set what to ignore
let g:pymode_lint_ignore = ["E501"]
" remove red column from screen
let g:pymode_options_colorcolumn = 0
