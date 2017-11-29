" Don't load another plugin for this buffer
let b:did_ftplugin = 1

" Compile current file to UNIX executable
" map <buffer> <C-k> :w!<C-m>:!clear; echo This is g++ compiling your shit % to executable ...; g++ % -o %< <C-m>

" Execute compiled file
map <buffer> <C-a> :!clear; echo Executing % ...;  ./%< <C-m>

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql

set syntax=cpp.doxygen

map <buffer> <C-k> :!tmux send-keys -t pg-compile "catkin_make -DCMAKE_BUILD_TYPE=Release -j7" Enter <CR><CR>

set colorcolumn=120
highlight ColorColumn ctermbg=darkgray

set commentstring=//\ %s
