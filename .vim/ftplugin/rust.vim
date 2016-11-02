map <buffer> <C-k> :w!<C-m>:!clear; echo This is rustc compiling your shit % to executable ...; rustc % -o %< <C-m>

" Execute compiled file
map <buffer> <C-a> :!clear; echo Executing % ...;  ./%< <C-m>

