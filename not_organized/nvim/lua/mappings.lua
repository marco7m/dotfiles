vim.api.nvim_create_autocmd(
    'FileType',
    { 
        pattern = { 'python'}, 
        callback = function()
            vim.api.nvim_buf_set_keymap(0, 'n', '<F9>', ':vs term://glow %<CR>', { noremap = true, desc = "open glow on a vsplit tab"})
        end
    }
)

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



vim.cmd([[
set backspace=indent,eol,start " faz o backspace funcionar igual no editores de texto normais
set ic " 'ignorecase'     ignora diferença entre maiúsculas/minúsculasi
set is " 'incsearch'      realiza a busca enquanto se digita
set hls " 'hlsearch'      realça todos os trechos localizados
set showmode " show insert/replace/visual mode (parece ja ser default, mas coloquei assim mesmo)
set wildmenu " Better command-line completion
"set nonu " Não coloca números nas linhas
set nu " Coloca número nas linhas
set scrolloff=6 " Faz a tela descer o sumir 6 linhas além do cursor quando possível 

"hide tool and menu bar
set guioptions-=T guioptions-=m

"faz os splits abrirem à esquerda e abaixo
set splitbelow
set splitright

" set backspace=indent,eol,start " backspacing over everything in insert mode

" file type specific settings
filetype on " enable file type detection
filetype plugin on " load the plugins for specific file types
filetype indent on " automatically indent code

"configura o TAB
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

"tira o highlight quando usa o #
nnoremap # #:nohl<CR>

"movimentação entre tabs
nnoremap <M-u> :tabprevious<CR>     
inoremap <M-u> <esc>:tabprevious<CR>
nnoremap <M-i> :tabnext<CR>         
inoremap <M-i> <esc>:tabnext<CR>    
tnoremap <silent> <M-u> <C-\><C-n>:tabprevious<CR>
tnoremap <silent> <M-i> <C-\><C-n>:tabnext<CR>

"redefinição de tamanho de janelas
nnoremap <Left> <C-w><
nnoremap <Right> <C-w>>
nnoremap <Up> <C-w>+
nnoremap <Down> <C-w>-
" nnoremap <esc><Left> <C-w>>
" nnoremap <esc><Right> <C-w><
" nnoremap <esc><Up> <C-w>+
" nnoremap <esc><Down> <C-w>-


nnoremap gd gd:nohl<CR>zz

"faz o autocomplete das chaves
inoremap {<CR> {<Enter>}<esc>ko

"tira o autocomplete dos colchetes
inoremap [ [

"insere uma nova linha com <enter>
nnoremap <enter> i<enter><esc>

"switch between header/source with F4
noremap <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
"smart comments
set comments=sl:/*,mb:\ *,elx:\ */ 

" CSCOPE
" Works with tag but only for .c and .h files (may also to .cpp if configured)
"-------------------------------------------------------------
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif


" 0 or s: Find this C symbol
" 1 or g: Find this definition
" 2 or d: Find functions called by this function
" 3 or c: Find functions calling this function
" 4 or t: Find this text string
" 6 or e: Find this egrep pattern
" 7 or f: Find this file
" 8 or i: Find files #including this file
" 9 or a: Find places where this symbol is assigned a value

nnoremap <C-]>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-]>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-]>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-]>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-]>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-]>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-]>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nnoremap <C-]>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-]>a :cs find a <C-R>=expand("<cword>")<CR><CR>

" para ativar syntax highlight
syntax enable

" para chamar :RustFmt sempre que salvar um arquivo .rs
let g:rustfmt_autosave = 1

" configuração do statusline
set laststatus=2 "ativa ele sempre

" add branch name to statusline
" set statusline+=set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P

set background=dark



"------------NOTAS------------
"
"abre o último arquivo aberto
"'0
"
"muda o diretório
":cd
"
"muda o diretório para o diretório do arquivo aberto
":cd %:p:h
"
"substitui todos os foo no arquivo por bar
":%s/foo/bar/g
"
"salva os folds ao fechar o arquivo, e ao reabrilo recarrega as configurações
"salvas dos folds
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview
"
"para gerar os arquivos tags e cscope.out
"ctags -R
"cscope -bR
]])
