map <buffer> <C-a> :w!<C-m>:!clear; echo This is Python devouring  "%" ...; ipython -i "%"<C-m>
"
" Comment line
noremap <buffer> - I# <Esc>

" Uncomment line
noremap <buffer> _ I<Right><Esc>xx
