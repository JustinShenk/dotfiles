if &compatible
    set nocompatible
endif

let mapleader="-"
let maplocalleader="-"

if v:version >= 800
    set runtimepath+=$HOME/.vim/bundle/repos/github.com/Shougo/dein.vim
    call dein#begin('$HOME/.vim/bundle/')
    " Let dein manage dein
    call dein#add('$HOME/.vim/bundle/repos/github.com/Shougo/dein.vim')
    call dein#add('vim-scripts/vim-auto-save')
    let g:auto_save = 1
    call dein#add('vim-scripts/LargeFile')
    call dein#add('Konfekt/FastFold')
    set foldmethod=syntax
    set foldlevel=2
    call dein#add('mildred/vim-bufmru')
    map <leader>n :BufMRUPrev<CR>
    map <leader>p :BufMRUNext<CR>
    call dein#add('w0rp/ale', {'on_ft': ['python', 'c', 'cpp']})
    let g:ale_python_pylint_executable = 'python'
    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 1
    let g:ale_lint_on_text_changed = 'never'
    let g:ale_lint_on_insert_leave = 0
    let g:ale_lint_on_enter = 0
    let g:ale_c_parse_compile_commands = 1

    let g:ale_linters = {
                \ 'python': ['pycodestyle', 'flake8', 'pylint', 'autopep8'],
                \ 'cpp': ['clang-format', 'cppcheck'],
                \}

    let g:ale_fixers = {
                \ 'python': ['add_blank_lines_for_python_control_statements',
                \            'autopep8', 'isort', 'yapf', 'black'],
                \ 'cpp': ['clang-format', 'cppcheck']
                \}

    let g:ale_set_signs = 1
    let g:ale_linters_explicit = 1
    let g:ale_sign_column_always = 1
    let g:ale_list_window_size = 15
    if has('python') || has('python3')
        " call dein#add('taketwo/vim-ros', {'on_ft': ['c', 'cpp', 'cmake', 'roslaunch', 'rosmsg', 'rosaction']})
        call dein#add('python-mode/python-mode', {'on_ft': ['python']})
        let g:pymode_folding = 0
        let g:pymode_rope = 0
        let g:pymode_rope_lookup_project = 0
        let g:pymode_lint = 0
    endif
    call dein#add('tarekbecker/vim-yaml-formatter', {'on_ft': ['yaml']})
    let g:yaml_formatter_indent_collection=1
    call dein#add('mg979/vim-visual-multi')
    call dein#add('sjl/gundo.vim')
    call dein#add('skywind3000/asyncrun.vim')
    call dein#add('tpope/vim-commentary')
    call dein#add('b4winckler/vim-angry')
    call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
    call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
    call dein#add('scrooloose/nerdtree')
    " Show hidden stuff in nerdtree
    let NERDTreeShowHidden=1
    " autocmd VimEnter * NERDTree | wincmd p
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")  && b:NERDTree.isTabTree()) | q | endif
    let NERDTreeQuitOnOpen=0

    call dein#add('tpope/vim-surround')
    call dein#add('godlygeek/tabular')
    call dein#add('vim-scripts/DoxygenToolkit.vim', {'on_ft': ['c', 'cpp']})

    call dein#add('SirVer/ultisnips', {'rev': '38b60d8e149fb38776854fa0f497093b21272884'})
    " For UltiSnips
    let g:UltiSnipsExpandTrigger="<C-J>"
    let g:UltiSnipsJumpForwardTrigger="<C-J>"
    let g:UltiSnipsJumpBackwardTrigger="<C-K>" " not working
    let g:ultisnips_python_style = "numpy"
    let g:ultisnips_python_triple_quoting_style = "single"
    let g:ultisnips_python_quoting_style = "single"
    call dein#add('honza/vim-snippets')

    call dein#add('Valloric/YouCompleteMe')
    let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_autoclose_preview_window_after_insertion = 1
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    let g:ycm_complete_in_comments = 1
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    let g:ycm_show_diagnostics_ui = 0
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_semantic_triggers = {
                \   'roslaunch' : ['="', '$(', '/'],
                \   'rosmsg,rossrv,rosaction' : ['re!^', '/'],
                \ }
    call dein#add('andymass/vim-matchup')
    let g:matchup_matchparen_deferred = 1
    call dein#add('lervag/vimtex', {'on_ft': ['tex', 'latex']})
    let g:vimtex_fold_enabled = 0
    call dein#add('NLKNguyen/papercolor-theme')
    set bg=light
    colo PaperColor " works with iterm material theme
    call dein#add('mhinz/vim-startify')
    " this is cool, but ctrl-f in command mode stops working and is replaced by ctrl-x ctrl-e
    " call dein#add('ryvnf/readline.vim')
    call dein#end()

    call dein#save_state()
    " If you want to install not installed plugins on startup.
    if dein#check_install()
        call dein#install()
    endif

    "End dein Scripts-------------------------
else
    echo "dein requires vim > 8, please upgrade and :call dein#update() manually."
endif

filetype plugin indent on
syntax enable


" highlight incremental matches while typing (you still need to press enter to get
" there)
set incsearch
set nohlsearch

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

set textwidth=88

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

" Capitalise each word in selection
vmap gw :s/\%V\<./\u&/g<CR>


" Syntax highlighting
syntax on

" not sure anymore what this does
" set omnifunc=syntaxcomplete#Complete

set wildmenu
set wildmode=list:longest

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
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode


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

" ignore case in filename tab completion
set wildignorecase

set laststatus=2

nnoremap gV `[v`]

" open Nerdtree files in new tab
let NERDTreeMapOpenInTab='<ENTER>'
" open Nerdtree on the right
let g:NERDTreeWinPos = "right"

" allow more than few open tabs
set tabpagemax=100

" don't break within words
" leads to word duplication
set linebreak

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

function! VM_Start()
    nmap <buffer> <C-C> <Esc>
    imap <buffer> <C-C> <Esc>
    call youcompleteme#DisableCursorMovedAutocommands()
endfunction

function! VM_Exit()
    nunmap <buffer> <C-C>
    iunmap <buffer> <C-C>
    call youcompleteme#EnableCursorMovedAutocommands()
endfunction

set modeline

map <leader><C-d> :set bg=dark<C-m>
map <leader><C-l> :set bg=light<C-m>
map <leader><C-h> :YcmCompleter GoToDeclaration<CR>

map <C-c> <Esc>
nmap <C-c> <Esc>
vmap <C-c> <Esc>
omap <C-c> <Esc>
imap <C-c> <Esc>
cmap <C-c> <Esc>
smap <C-c> <Esc>
xmap <C-c> <Esc>
lmap <C-c> <Esc>
tmap <C-c> <Esc>

" for showing length of selection
set showcmd

set exrc
set secure
map <leader><C-f> :Files<CR>

map <C-s> :wa<CR>
set cursorcolumn
set cursorline

" this may mess up substitution
set ignorecase
set smartcase
" solves clipboard not working with neovim on elementary. Does not work for vim
set clipboard=unnamedplus
