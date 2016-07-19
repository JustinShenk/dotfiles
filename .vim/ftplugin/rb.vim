inoremap <buffer> <Char-124> <Char-124><Char-124><Esc>i

map <buffer> <C-a> :wa!<C-m>:!clear; echo Hello, this is Ruby. Running  % ...; ruby % <C-m>

set commentstring=#%s
