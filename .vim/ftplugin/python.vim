" CUSTOM COMMANDS "
map <buffer> <C-a> :w!<C-m>:!clear; echo This is Python devouring  % ...; python3 -i %<C-m>

if !exists('*Black_format')
    func! Black_format()
        let save_cursor = getcurpos()
        exe 'w'
        exe 'silent !black %'
        exe 'edit'
        call setpos('.', save_cursor)
    endfunc
endif

nnoremap <buffer> <C-f> :call Black_format()<CR>
