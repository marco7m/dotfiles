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
Plug 'https://github.com/jistr/vim-nerdtree-tabs'
Plug 'junegunn/goyo.vim', {'on':'Goyo'}
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'Valloric/YouCompleteMe'
Plug 'majutsushi/tagbar'
Plug 'aserebryakov/vim-todo-lists'
Plug 'lifepillar/vim-solarized8'
Plug 'rust-lang/rust.vim'

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

" NERDTREE = NERDTREETABS ====================================
"fecha Vim se a única janela aberta é o nerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1

" same as NERDTreeToggle but with NERDTreeFind [not used anymore because of nerdtreetabs]
"nnoremap <silent> <expr> <C-n> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
nnoremap <silent> <expr> <C-n> "\:NERDTreeTabsToggle<CR>"

" Open NERDTree on console vim startup. (When set to 2, open only if directory
" param 0: never
" param 1: always
" param 2: only if directory given as statup argument
let g:nerdtree_tabs_open_on_console_startup=2

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

"-------------------------------------------------------------
" === Put visual selection on system clipboard
" [TODO] make it work for different types of visual modes
"        visual block bugs out
" [TODO][BUG] % and # doesnt copy well
" [TODO][BUG] aspas simples ' bugam e faz ele não funcionar

function! VisualSelection()
    if mode()=="v"
        let [line_start, column_start] = getpos("v")[1:2]
        let [line_end, column_end] = getpos(".")[1:2]
    else
        let [line_start, column_start] = getpos("'<")[1:2]
        let [line_end, column_end] = getpos("'>")[1:2]
    end
    if (line2byte(line_start)+column_start) > (line2byte(line_end)+column_end)
        let [line_start, column_start, line_end, column_end] =
        \   [line_end, column_end, line_start, column_start]
    end
    let lines = getline(line_start, line_end)
    if len(lines) == 0
            return ''
    endif
    let lines[-1] = lines[-1][: column_end - 1]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

" must have xsel installed
function! CopySelection()
    " only works on visual mode
    let a = VisualSelection()
    execute "silent !printf '" . a . "' | xsel -ib"
    redraw! "silent on the command above requires that I redraw the screen on some systems
    echo "Visual selection yanked to clipboard"
endfunction

vnoremap <C-c> :call CopySelection()<CR>
nnoremap cV V:call CopySelection()<CR>

"-------------------------------------------------------------
" vim mergetool
nnoremap ]r :diffget REMOTE
nnoremap ]b :diffget BASE
nnoremap ]l :diffget LOCAL
"-------------------------------------------------------------
" para ativar syntax highlight
syntax enable

" para para de gerar o arquivo netrwhist que contem o historico de mudanças na
" pasta do .vim
let g:netrw_dirhistmax=0

" para chamar :RustFmt sempre que salvar um arquivo .rs
let g:rustfmt_autosave = 1

" configuração do statusline
set laststatus=2 "ativa ele sempre

set background=dark
"colorscheme elflord
colorscheme solarized8_high

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
