map <buffer> <C-k> :w!<C-m> :!clear; dot -Tpdf % > %<.pdf <C-m>
map <buffer> <C-a> :!clear; open  ./%<.pdf<C-m>
