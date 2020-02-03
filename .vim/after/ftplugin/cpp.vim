function CompileAndRunQuick()
    :tablast
    :AsyncRun -cwd=<root> -raw make && ./bin/*
endfunction

function CompileAndRun()
    :AsyncRun -cwd=<root> -raw make && ./bin/*
    :tabnew
    :botright copen
    "wincmd = <C-w> in normal mode
    :wincmd k 
    :q
endfunction

function CleanCompileAndRun()
    :AsyncRun -cwd=<root> -raw make clean && make && ./bin/*
    :tabnew
    :botright copen
    "wincmd = <C-w> in normal mode
    :wincmd k 
    :q
endfunction

function CleanCompile()
    :AsyncRun -cwd=<root> -raw make clean && make && ./bin/*
    :tabnew
    :botright copen
    "wincmd = <C-w> in normal mode
    :wincmd k 
    :q
endfunction

"nnoremap <silent> <F9> :AsyncRun -cwd=<root> -raw make && ./bin/* <cr>
nnoremap <silent> <F9> :call CompileAndRunQuick() <cr>
nnoremap <silent> <F9><F9> :call CompileAndRun() <cr>

nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make clean && make && ./bin/* <cr>
nnoremap <silent> <F6><F6> :call CleanCompileAndRun() <cr>

nnoremap <silent> <F5> :AsyncRun -cwd=<root> -raw make clean && make <cr>
nnoremap <silent> <F5><F5> :call CleanCompile() <cr>

nnoremap <silent> <leader>p astd::cout << "" << std::endl;<esc>bbbbba
inoremap <silent> <leader>p std::cout << "" << std::endl;<esc>bbbbba
