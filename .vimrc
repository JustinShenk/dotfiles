" Vundle setup
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'mikewest/vimroom'
if v:version >= 800
    Plugin 'w0rp/ale'
endif
Plugin 'sjl/gundo.vim'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'tpope/vim-commentary'
Plugin 'b4winckler/vim-angry'
Plugin 'junegunn/goyo.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'godlygeek/tabular'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
if has('python')
    Plugin 'taketwo/vim-ros'
endif
Plugin 'Valloric/YouCompleteMe'
Plugin 'lervag/vimtex'
Plugin 'altercation/vim-colors-solarized'
Plugin 'mhartington/oceanic-next'
Plugin 'mhinz/vim-startify'
Plugin 'python-mode/python-mode'
call vundle#end()

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
map <C-p> :set paste<C-m>a<C-r>*<C-m><Esc>:set nopaste<C-m>

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

" for vim-airline
let g:airline#extensions#tabline#enabled = 1

" not sure anymore what this does
set omnifunc=syntaxcomplete#Complete

" not sure anymore what this does
set wildmode=longest,list

" allow to switch buffers when unsaved changes in current buffer
set hidden

let mapleader="-"
" for YouCompleteMe
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_complete_in_comments = 1
let g:ycm_show_diagnostics_ui = 0
nmap <C-c> :YcmCompleter GetDoc<CR>
let g:ycm_semantic_triggers = {
\   'roslaunch' : ['="', '$(', '/'],
\   'rosmsg,rossrv,rosaction' : ['re!^', '/'],
\ }
" For UltiSnips
let g:UltiSnipsExpandTrigger="<C-J>"
let g:UltiSnipsJumpForwardTrigger="<C-J>"
let g:UltiSnipsJumpBackwardTrigger="<C-K>" " not working


" C++ template files; does not work with ftplugin
autocmd BufEnter *.tpp :setlocal filetype=cpp syntax=cpp

" LaTeX class files
autocmd BufEnter *.cls :setlocal filetype=tex

" Show hidden stuff in nerdtree
let NERDTreeShowHidden=1

" Replace math tex commands with unicode glyphs
set cole=2

hi Comment cterm=bold
" let g:auto_save = 1  " enable AutoSave on Vim startup
" let g:auto_save_in_insert_mode = 0  " do not save while in insert mode

let g:ale_python_pylint_executable = 'python3.6'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

let g:ale_linters = {
            \ 'python': ['pycodestyle', 'flake8', 'pylint', 'autopep8'],
            \ 'cpp': ['cpplint', 'clang-format'],
            \}

let g:ale_fixers = {
            \ 'python': ['add_blank_lines_for_python_control_statements',
            \            'autopep8', 'isort', 'yapf'],
            \ 'cpp': ['clang-format']
            \}

let g:ale_cpp_cpplint_options = '--filter=-whitespace/braces --linelength=120'

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
       exec "AsyncRun! time python3 %"
    endif
endfunction

set formatoptions+=j " Delete comment character when joining commented lines

" scroll wheel moves through time instead of space " <https://xkcd.com/1806/>
" set mouse=a
" nnoremap <ScrollWheelUp> u
" nnoremap <ScrollWheelDown> <C-r>
" inoremap <ScrollWheelUp> <Esc>ui
" inoremap <ScrollWheelDown> <Esc><C-r>i

autocmd BufWrite * silent! :%s/\s\+$//g

let g:solarized_termcolors=256
set t_Co=256
colo solarized

set backspace=indent,eol,start
set smarttab
set wildmenu
set scrolloff=5

" python-mode
if has('python3')
    let g:pymode_python = 'python3'
endif
let g:pymode_options_max_line_length = 100
let g:pymode_folding = 0
let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_lint = 0

" Solarized colorscheme
let g:solarized_termcolors=256
set t_Co=256
set bg=dark
colo solarized

let g:ultisnips_python_style = "numpy"
let g:ultisnips_python_triple_quoting_style = "single"

set laststatus=2

nnoremap B ^
nnoremap ^ <nop>
nnoremap E $
nnoremap $ <nop>

nnoremap gV `[v`]
