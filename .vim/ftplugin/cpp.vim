" Don't load another plugin for this buffer
let b:did_ftplugin = 1

" Compile current file to UNIX executable
map <buffer> <C-k> :!tmux send-keys -t 1-run-core C-u "make -j12" Enter<CR><CR>

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql

nnoremap <C-f> :call Clang_format()<CR>

func! Clang_format()
    let save_cursor = getcurpos()
    exe '%!clang-format -style=file'
    call setpos('.', save_cursor)
endfunc
