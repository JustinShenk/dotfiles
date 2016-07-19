" Don't load another plugin for this buffer
let b:did_ftplugin = 1

" Compile current file to UNIX executable
map <buffer> <C-k> :w!<C-m>:!clear; echo This is clang compiling your shit % to executable ...; clang % -o %< <C-m>

" Execute compiled file
map <buffer> <C-a> :!clear; echo Executing % ...;  ./%< <C-m>

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql
