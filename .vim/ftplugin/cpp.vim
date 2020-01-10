" Don't load another plugin for this buffer
" let b:did_ftplugin = 1

" Compile current file to UNIX executable
map <buffer> <C-k> :wa<CR>:!tmux send-keys -t 1-run-core C-u "try_make" Enter<CR><CR>
setlocal commentstring=/*%s*/
