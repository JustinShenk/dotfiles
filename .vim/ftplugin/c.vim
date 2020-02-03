nnoremap <buffer> <C-f> :call Clang_format()<CR>

func! Clang_format()
    let save_cursor = getcurpos()
    exe '%!clang-format -style=file'
    call setpos('.', save_cursor)
endfunc

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql

" ctags
nmap <leader><C-I> <C-]>
set tags+=~/.vim/tags/cpp/tags

function! s:build_ctags()
    exec "AsyncRun! ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q ."
endfunction

map <leader><C-T> :call <SID>build_ctags()<CR>
