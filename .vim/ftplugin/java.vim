" This makes use of filename-modifiers (:help filename-modifiers) to get the
" full path, replace 'src' and all following stuff by 'bin' where all class
" files live. For compiling, the same expression is ised as classpath option
" (must be extended with $CLASSPATH for further directoires).
map <buffer> <C-k> :w!<C-m>:!clear; echo Compiling % ...; javac -encoding UTF-8 -cp "%:p:r:s?/src.*?/bin?" -d "%:p:r:s?/src.*?/bin?" "%:p"<C-m>

" The expression here takes the full path (p), removes the file extension (r),
" and replaces everything before and including 'src' by nothing, as well as the
" first ocurrence of '/' by nothing, since this is a trailing slash which java
" will interpret as a package separator ('.')
map <buffer> <C-a> :!clear; echo Executing % ...; java -cp "%:p:r:s?/src.*?/bin?" "%:p:r:s?.*src??:s?^/??" 


" Insert current filename w/o extension at cursor position when in insertmode
inoremap <buffer> filename <C-R>=expand("%:t:r")<CR>

" insert current timestamp
inoremap <buffer> time <C-R>=strftime("%Y-%m-%d")<CR>

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using o.
setlocal fo-=t fo+=croql
