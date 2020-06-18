function! RangeChooser()
    let temp = tempname()
    " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
    " with ranger 1.4.2 through 1.5.0 instead.
    "exec 'silent !ranger --choosefile=' . shellescape(temp)
    if has("gui_running")
        exec 'silent !xterm -e ranger --choosefiles=' . shellescape(temp)
    else
        exec 'silent !ranger --choosefiles=' . shellescape(temp)
    endif
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction
command! -bar RangerChooser call RangeChooser()
nnoremap <leader>r :<C-U>RangerChooser<CR>

"-------------------------------------------------------------------------------
"=====   vim-plug configuration

" specify a directory for plugins
call plug#begin('~/.vim/vim-plug-plugins')

Plug 'https://github.com/scrooloose/nerdtree'
Plug 'junegunn/goyo.vim', {'on':'Goyo'}
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'Valloric/YouCompleteMe'
Plug 'majutsushi/tagbar'
Plug 'aserebryakov/vim-todo-lists'

" Initialize plugin system
call plug#end()

"-------------------------------------------------------------------------------

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

"press F8 to turn the search results highlight off
noremap <F8> :nohl<CR>
inoremap <F8> <Esc>:nohl<CR>

"press \cd to set the folder of vim the same of the file's folder
nnoremap \cd :cd %:p:h<CR>

"configura o TAB
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

"tira o highlight quando usa o #
nnoremap # #:nohl<CR>

nnoremap <C-j> <C-y><C-w><C-w><C-y><C-w><C-w>
nnoremap <C-k> <C-e><C-w><C-w><C-e><C-w><C-w>

"faz ter que digitar jk para sair do insert mode
inoremap jk <esc> 
inoremap JK <esc> 

"faz a barra de espaço colocar :
nnoremap <space> :

"movimentação entre tabs
nnoremap <esc>u :tabprevious<CR>
inoremap <esc>u <esc>:tabprevious<CR>
nnoremap <esc>i :tabnext<CR>
inoremap <esc>i <esc>:tabnext<CR>

"movimentação entre windows
nnoremap <esc>l <C-w>l
nnoremap <esc>j <C-w>j
nnoremap <esc>h <C-w>h
nnoremap <esc>k <C-w>k

"redefinição de tamanho de janelas
nnoremap <esc><Left> <C-w>>
nnoremap <esc><Right> <C-w><
nnoremap <esc><Up> <C-w>+
nnoremap <esc><Down> <C-w>-

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

"faz a autoidentação não atrapalhar na hora de colar um texto
nnoremap <F5> :set invpaste paste?<Enter>
imap <F5> <C-O><F5>
set pastetoggle=<F5>

" NERDTREE ===================================================
"fecha Vim se a única janela aberta é o nerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1
" same as NERDTreeToggle but with NERDTreeFind
nnoremap <silent> <expr> <C-n> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

"função para trocar os buffers de duas janelas
"para usa-la basta ir em uma janela e apertar \mw e na outra \pw
"-------------------------------------------------------------
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf 
endfunction

nnoremap <silent> <leader>wm :call MarkWindowSwap()<CR>
nnoremap <silent> <leader>wp :call DoWindowSwap()<CR>

"-------------------------------------------------------------

if has("gui_running")
    :colorscheme solarized
endif

" para ativar syntax highlight
syntax on
colorscheme elflord

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
