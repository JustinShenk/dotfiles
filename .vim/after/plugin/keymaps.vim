" Placing key mappings inot after avoids surprises when plugins map keys you
" usually use for something else.


" source this file whenever saved
" autocmd BufWritePost .vimrc source %

" when you forget to sudo
cmap w!! w !sudo tee > /dev/null %

" set encoding=utf-8
set fileencoding=utf-8

" jump between angle brackets
set matchpairs+=<:>

" autocomplete parens
inoremap ( ()<Esc>i

inoremap { {}<Esc>i

inoremap [ []<Esc>i

inoremap " ""<Esc>i

inoremap ' ''<Esc>i

" make j and k move display lines, not real lines. wrapped (not broken) text is
" annoying otherwise
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

" saving all buffers
nmap ü :wa<CR>

" shortcut to paste code from system clipboard
map <C-p> :set paste<C-m>a<C-r>*<C-m><Esc>:set nopaste<C-m>

" Enable mouse with option key press (not needed in iTerm)
set mouse=a

" switch tabs quicker
nnoremap <C-h> gT
nnoremap <C-l> gt

" Enable automatic indentation
set autoindent

" Line numbers
set number

" Set column width to 80 characters
set textwidth=80

" Shortcuts for english and german spellchek
map <F1> :set spell spelllang=en_gb <CR>
map <F2> :set spell spelllang=de <CR>
map <F3> :set nospell <CR>


" easier moving of visually selected lines
vnoremap < <gv
vnoremap > >gv

" select word in normal mode
nmap <space> viw
" ... and then unselect with same key
vmap <space> <esc>

map <leader>n :bnext<CR>
map <leader>p :bprevious<CR>

" Capitalise each word in selection
vmap gw :s/\%V\<./\u&/g<CR>


" Quick run via <F5>
nnoremap <C-s> :call <SID>compile_and_run()<CR>

