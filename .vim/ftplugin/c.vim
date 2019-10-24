" Don't load another (c++) plugin for this buffer
let b:did_ftplugin = 1

inoremap <buffer> <Char-246> oe
inoremap <buffer> <Char-228> ae
inoremap <buffer> <Char-252> ue
inoremap <buffer> ß ss
inoremap <buffer> <Char-196> Ae
inoremap <buffer> <Char-220> Ue
inoremap <buffer> <Char-214> Oe

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql
