map <buffer> <C-a> :w<CR>:!clear; echo Starting % ...; clisp -L english -i %<CR>

" Comment line
map <buffer> - I;;; <Esc>

" Uncomment line
map <buffer> _ I<Esc>xxxx

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql
