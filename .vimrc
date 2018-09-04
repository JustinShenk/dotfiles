" Vundle setup
set nocompatible              " be iMproved, required
filetype off                  " required

set runtimepath+=$HOME/.vim/bundle/repos/github.com/Shougo/dein.vim

" if dein#load_state('$HOME/.vim/bundle/')
call dein#begin('$HOME/.vim/bundle/')
" Let dein manage dein
call dein#add('$HOME/.vim/bundle/repos/github.com/Shougo/dein.vim')

call dein#add('vim-scripts/LargeFile')

" Add or remove your plugins here:
" if v:version >= 800
"     call dein#add('w0rp/ale', {'on_ft': ['python', 'c', 'cpp']})
"         let g:ale_python_pylint_executable = 'python'
"         let g:ale_lint_on_text_changed = 'never'
"         let g:ale_lint_on_enter = 0

"         let g:ale_linters = {
"                     \ 'python': ['pycodestyle', 'flake8', 'pylint', 'autopep8'],
"                     \ 'cpp': ['cpplint', 'clang-format'],
"                     \}

"         let g:ale_fixers = {
"                     \ 'python': ['add_blank_lines_for_python_control_statements',
"                     \            'autopep8', 'isort', 'yapf'],
"                     \ 'cpp': ['clang-format']
"                     \}

"         let g:ale_cpp_cpplint_options = '--filter=-whitespace/braces --linelength=120'
"         let g:ale_python_pycodestyle_options = '--max-line-length=120'
"         let g:ale_python_flake8_options = '--max-line-length=120'
"         let g:ale_python_autopep8_options = '--max-line-length=120'
" endif
if has('python') || has('python3')
    call dein#add('taketwo/vim-ros', {'on_ft': ['c', 'cpp', 'cmake', 'roslaunch', 'rosmsg', 'rosaction']})
    call dein#add('python-mode/python-mode', {'on_ft': ['python']})
        let g:pymode_options_max_line_length = 100
        let g:pymode_folding = 0
        let g:pymode_rope = 0
        let g:pymode_rope_lookup_project = 0
        let g:pymode_lint = 1
        let g:pymode_lint_on_write = 1
        let g:pymode_lint_ignore = ['E221', 'E222', 'E252']
endif
if has('python3')
        let g:pymode_python = 'python3'
endif
call dein#add('terryma/vim-multiple-cursors')
    " Default mapping
    let g:multi_cursor_next_key='<C-n>'
    let g:multi_cursor_prev_key='<C-p>'
    let g:multi_cursor_skip_key='<C-x>'
    let g:multi_cursor_quit_key='<Esc>'
call dein#add('mikewest/vimroom')
call dein#add('sjl/gundo.vim')
call dein#add('skywind3000/asyncrun.vim')
call dein#add('tpope/vim-commentary')
call dein#add('b4winckler/vim-angry')
call dein#add('junegunn/goyo.vim')
call dein#add('scrooloose/nerdtree')
    " Show hidden stuff in nerdtree
    let NERDTreeShowHidden=1
call dein#add('tpope/vim-surround')
call dein#add('airblade/vim-gitgutter')
call dein#add('godlygeek/tabular')
call dein#add('vim-scripts/DoxygenToolkit.vim', {'on_ft': ['c', 'cpp']})
call dein#add('SirVer/ultisnips')
    " For UltiSnips
    let g:UltiSnipsExpandTrigger="<C-J>"
    let g:UltiSnipsJumpForwardTrigger="<C-J>"
    let g:UltiSnipsJumpBackwardTrigger="<C-K>" " not working
    let g:ultisnips_python_style = "numpy"
    let g:ultisnips_python_triple_quoting_style = "single"
    let g:ultisnips_python_quoting_style = "single"
call dein#add('honza/vim-snippets')
call dein#add('Valloric/YouCompleteMe', {'build': './install.py --clang-completer'})
    " for YouCompleteMe
    let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_autoclose_preview_window_after_insertion = 1
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    let g:ycm_complete_in_comments = 1
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    let g:ycm_show_diagnostics_ui = 0
    nmap <C-c> :YcmCompleter GetDoc<CR>
    let g:ycm_semantic_triggers = {
    \   'roslaunch' : ['="', '$(', '/'],
    \   'rosmsg,rossrv,rosaction' : ['re!^', '/'],
    \ }
call dein#add('lervag/vimtex', {'on_ft': ['tex']})
call dein#add('altercation/vim-colors-solarized')
    " Solarized colorscheme

    let g:solarized_termcolors=256
    set t_Co=256
    set bg=dark
    colo solarized
call dein#add('mhinz/vim-startify')
call dein#end()
call dein#save_state()

filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" Enable filetype plugins
filetype plugin indent on

" highlight incremental matches while typing (you still need to press enter to get
" there)
set incsearch

" Tabwidth
set tabstop=4

" Since apparently backspace stopped working as usual in vim 7.3, this is
" necessary
set bs=2

" Show current row and column number
set ruler

set shiftwidth=4

" let tabs be spaces
set expandtab

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
" map <C-p> :set paste<C-m>a<C-r>*<C-m><Esc>:set nopaste<C-m>

" Enable mouse with option key press (not needed in iTerm)
set mouse=a

" switch tabs quicker
nnoremap <C-h> gT
nnoremap <C-l> gt
map <C-l> gt

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

let mapleader="-"
map <leader>n :bnext<CR>
map <leader>p :bprevious<CR>

" Capitalise each word in selection
vmap gw :s/\%V\<./\u&/g<CR>


" Quick run via <F5>
nnoremap <C-s> :call <SID>compile_and_run()<CR>


" Syntax highlighting
syntax on

" not sure anymore what this does
set omnifunc=syntaxcomplete#Complete

" not sure anymore what this does
set wildmode=longest,list

" allow to switch buffers when unsaved changes in current buffer
set hidden

" ROS launch files
autocmd BufEnter *.launch :setlocal filetype=launch syntax=xml

" C++ template files; does not work with ftplugin
autocmd BufEnter *.tpp :setlocal filetype=cpp syntax=cpp

" LaTeX class files
autocmd BufEnter *.cls :setlocal filetype=tex

" Replace math tex commands with unicode glyphs
set cole=2

hi Comment cterm=bold
" let g:auto_save = 1  " enable AutoSave on Vim startup
" let g:auto_save_in_insert_mode = 0  " do not save while in insert mode

augroup SPACEVIM_ASYNCRUN
    autocmd!
    " Automatically open the quickfix window
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
augroup END

function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! clang % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! clang++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python %"
    endif
endfunction

set formatoptions+=j " Delete comment character when joining commented lines

" scroll wheel moves through time instead of space " <https://xkcd.com/1806/>
" set mouse=a
" nnoremap <ScrollWheelUp> u
" nnoremap <ScrollWheelDown> <C-r>
" inoremap <ScrollWheelUp> <Esc>ui
" inoremap <ScrollWheelDown> <Esc><C-r>i

" strip trailing whitespace at the end of any line
autocmd BufWrite * silent! :%s/\s\+$//g
" strip trailing newlines
autocmd BufWrite * silent! :%s#\($\n\s*\)\+\%$##

set backspace=indent,eol,start
set smarttab
set wildmenu
set scrolloff=5

set laststatus=2

nnoremap gV `[v`]

" open Nerdtree files in new tab
let NERDTreeMapOpenInTab='<ENTER>'
" open Nerdtree on the right
let g:NERDTreeWinPos = "right"

