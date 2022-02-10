if &compatible
  set nocompatible " Be iMproved
endif

" highlight incremental matches while typing (you still need to press enter to get
" there)
set incsearch
set nohlsearch

set backspace=indent,eol,start

" allow to switch buffers when unsaved changes in current buffer
set hidden

" Required:
" Add the dein installation directory into runtimepath
set runtimepath+=$HOME/.vim/bundle/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('$HOME/.vim/bundle/')
" Let dein manage dein
call dein#add('$HOME/.vim/bundle/repos/github.com/Shougo/dein.vim')
call dein#add('lifepillar/vim-solarized8')
call dein#add('vim-scripts/vim-auto-save')
"call dein#add('nvim-lua/plenary.nvim')
"call dein#add('nvim-telescope/telescope.nvim')

" add pywrite

call dein#add('vim-scripts/LargeFile')
call dein#add('Konfekt/FastFold')
set foldmethod=syntax
set foldlevel=2
call dein#add('preservim/nerdcommenter')
call dein#add('scrooloose/nerdtree')
  " Show hidden stuff in nerdtree
let NERDTreeShowHidden=1
" autocmd VimEnter * NERDTree | wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")  && b:NERDTree.isTabTree()) | q | endif
let NERDTreeQuitOnOpen=0
call dein#add('Valloric/YouCompleteMe', {'build': './install.py --clang-completer'})
" disable annoying doc popup
let g:ycm_auto_hover=''
let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>', '<TAB>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>','<S-TAB>']
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_semantic_triggers = {
           \   'roslaunch' : ['="', '$(', '/'],
           \   'rosmsg,rossrv,rosaction' : ['re!^', '/'],
           \ }

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
colo solarized8
set bg=dark


" Required:
call dein#end()
call dein#save_state()

" Required:
filetype plugin indent on
syntax enable

" Tabwidth
set tabstop=4

" Since apparently backspace stopped working as usual in vim 7.3, this is
" necessary
set bs=2

" Show current row and column number
set ruler
set number

set shiftwidth=4

" let tabs be spaces
set expandtab

" source this file whenever saved
" autocmd BufWritePost .vimrc source %

" set encoding=utf-8
set fileencoding=utf-8

" jump between angle brackets
set matchpairs+=<:>

" autocomplete parens
"inoremap ( ()<Esc>i

"inoremap { {}<Esc>i

"inoremap [ []<Esc>i

"inoremap " ""<Esc>i

"inoremap ' ''<Esc>i

" make j and k move display lines, not real lines. wrapped (not broken) text is
" annoying otherwise
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

" Remap Esc
:imap jj <Esc>

" saving all buffers
nmap ü :wa<CR>

set textwidth=88

" Replace math tex commands with unicode glyphs
set cole=2

hi Comment cterm=bold
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode


set formatoptions+=j " Delete comment character when joining commented lines


" strip trailing whitespace at the end of any line
autocmd BufWrite * silent! :%s/\s\+$//g
" strip trailing newlines
autocmd BufWrite * silent! :%s#\($\n\s*\)\+\%$##

set smarttab
set wildmenu

" ignore case in filename tab completion
set wildignorecase

set laststatus=2

let mapleader = "," " map leader to comma

" infinite undo, across restarts
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
let myUndoDir = expand(vimDir . '/undodir')
" Create dirs
call system('mkdir ' . vimDir)
call system('mkdir ' . myUndoDir)
let &undodir = myUndoDir
set undofile

" If you want to install not installed plugins on startup.
if dein#check_install()
 call dein#install()
endif

" Automatically paste in paste mode
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

se mouse+=a " prevent copying line numbers

set clipboard=unnamed " copy to system clipboard
