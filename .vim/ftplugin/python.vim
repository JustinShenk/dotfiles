" CUSTOM COMMANDS "
 map <buffer> <C-a> :w!<C-m>:!clear; echo This is Python devouring  % ...; python3 -i %<C-m>

func! Black_format()
    let save_cursor = getcurpos()
    exe '%!black'
    call setpos('.', save_cursor)
endfunc

nnoremap <C-f> :call Black_format()<CR>
