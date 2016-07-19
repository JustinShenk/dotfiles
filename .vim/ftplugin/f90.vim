set ft=fortran

" Compile current file to executable
map <buffer> <C-k> :w!<C-m>:!clear; echo This is gfortran compiling your shit % to executable ...; gfortran -O3 -fbounds-check -Wall -Wextra -o %< % <C-m>

" Execute compiled file
map <buffer> <C-a> :!clear; echo Executing % ...;  ./%< <C-m>
