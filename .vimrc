" Init Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugin 'junegunn/limelight.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'godlygeek/tabular'
Plugin 'bling/vim-airline'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
" Plugin 'lervag/vimtex'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()

" source this file whenever saved
autocmd BufWritePost .vimrc source %

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

" highlight incremental matches while typing (you still need to press enter to get
" there)
set incsearch

" shortcut to paste code from system clipboard
map <C-p> :set paste<C-m>a<C-r>*<C-m><Esc>:set nopaste<C-m>


" Solarized colorscheme
if !has('gui_running')
   let g:solarized_termcolors=256
endif
set background=dark
colorscheme solarized
hi Visual ctermbg=105
hi MatchParen cterm=bold ctermbg=125 ctermfg=0
hi Normal ctermfg=253

" colo sweater

" Enable mouse with option key press (not needed in iTerm)
set mouse=a

" switch tabs quicker
map <C-h> gT
map <C-l> gt

" Enable automatic indentation
set autoindent
set smartindent

" Line numbers
set number

" Set column width to 80 characters
set textwidth=80

" Shortcuts for english and german spellchek
map <F1> :set spell spelllang=en_gb <CR>
map <F2> :set spell spelllang=de <CR>
map <F3> :set nospell <CR>


" Tabwidth
set tabstop=3

" Since apparently backspace stopped working as usual in vim 7.3, this is
" necessary
set bs=2

" Show current row and column number
set ruler

" Enforce linebreaking at textwidth although some filteypes disagree
" autocmd BufNewFile,BufRead * setlocal formatoptions+=croqlt

set shiftwidth=3

" easier moving of visually selected lines
vnoremap < <gv
vnoremap > >gv

" let tabs be spaces
set expandtab

" specify dictionary
set dictionary+=/usr/share/dict/words 
set dictionary+=/usr/share/dict/propernames

" pathogen
" call pathogen#infect()
" Helptags

" Enable filetype plugins
filetype on
filetype plugin indent on

" Syntax highlighting
syntax on

" for vim-airline
let g:airline#extensions#tabline#enabled = 1
 
" for syntastic
" error line highlighting for syntastic
" hi SyntasticErrorLine ctermbg=1
let g:syntastic_tex_checkers=['']
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_c_include_dirs = [ '../include', 'include', '/opt/local/include', '/usr/local/include']
let g:syntastic_c_check_header = 1
let g:syntastic_cpp_include_dirs = g:syntastic_c_include_dirs
let g:syntastic_cpp_check_header = g:syntastic_c_check_header

" not sure anymore what this does
set omnifunc=syntaxcomplete#Complete

" not sure anymore what this does
set wildmode=longest,list

" languagetool path for grammar checking
let g:languagetool_jar='/Applications/LanguageTool-3.0/languagetool-commandline.jar'

" select word in normal mode
nmap <space> viw
" ... and then unselect with same key
vmap <space> <esc>

" allow to switch buffers when unsaved changes in current buffer
set hidden

let mapleader="-"
map <leader>n :bnext<CR>
map <leader>p :bprevious<CR>

" Capitalise each word in selection
vmap gw :s/\%V\<./\u&/g<CR>


" for YouCompleteMe
let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>']

" For UltiSnips
let g:UltiSnipsExpandTrigger="<C-J>"
" let g:UltiSnipsListSnippets="<C-TAB>"
let g:UltiSnipsJumpForwardTrigger="<C-J>"
let g:UltiSnipsJumpBackwardTrigger="<C-K>"

" C++ template files; does not work with ftplugin
" autocmd BufEnter *.tpp :setlocal filetype=cpp syntax=cpp

" LaTeX class files
autocmd BufEnter *.cls :setlocal filetype=tex

" Show hidden stuff in nerdtree
let NERDTreeShowHidden=1
