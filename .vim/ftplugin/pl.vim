" Consult file in swipl
map <buffer> <C-k> :w!<C-m>:!clear; echo This is swipl. Consulting  % ...; swipl -s % <C-m>

" Comment line
map <buffer> - I% <Esc>

" Uncomment line
map <buffer> _ I<Esc>xx

hi statement cterm=none
