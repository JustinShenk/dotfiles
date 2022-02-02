if &compatible
  set nocompatible " Be iMproved
endif

" highlight incremental matches while typing (you still need to press enter to get
" there)
set incsearch
set nohlsearch
set ignorecase

set backspace=indent,eol,start

"CoC config0-----------------------------
set nobackup
set nowritebackup

set cmdheight=2
set updatetime=300
set shortmess+=c

let mapleader = "," " map leader to comma

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" end CoC----------------------------------------

" allow to switch buffers when unsaved changes in current buffer
set hidden

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/justinshenk/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/Users/justinshenk/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('/Users/justinshenk/.cache/dein/repos/github.com/Shougo/dein.vim')

" Functional
call dein#add('nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'})
call dein#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'release' })
call dein#add('preservim/nerdcommenter')
call dein#add('scrooloose/nerdtree')
call dein#add('nvim-telescope/telescope.nvim')
call dein#add('tpope/vim-fugitive')
"call dein#add('taohexxx/lightline-solarized')

" Look and feel
"call dein#add('sainnhe/sonokai')
"call dein#add('kyazdani42/nvim-web-devicons')
call dein#add('itchyny/lightline.vim')
call dein#add('lifepillar/vim-solarized8')
call dein#add('vim-scripts/vim-auto-save')
call dein#add('nvim-lua/plenary.nvim')
call dein#add('vim-scripts/LargeFile')
call dein#add('Konfekt/FastFold')

" call dein#add('Valloric/YouCompleteMe', {'build': './install.py --clang-completer'})
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

set foldmethod=syntax
set foldlevel=2
  " Show hidden stuff in nerdtree
let NERDTreeShowHidden=1
" autocmd VimEnter * NERDTree | wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")  && b:NERDTree.isTabTree()) | q | endif
let NERDTreeQuitOnOpen=0
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

let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " True gui colors in terminal

if exists('+termguicolors') && ($TERM == "st-256color" || $TERM == "tmux-256color")
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

" The configuration options should be placed before `colorscheme sonokai`.
"let g:sonokai_style = 'andromeda'
"let g:sonokai_enable_italic = 1
"let g:sonokai_disable_italic_comment = 1
colorscheme solarized8

" use lightline-solarized in lightline
"let g:lightline = {
	"\ 'colorscheme': 'lightline_solarized',
	"\ }
"let g:solarized_temcolors=16
"colorscheme solarized
let g:solarized_termtrans = 1
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"

" Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
"nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({}))<cr>
"nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
"nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
"nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" Required:
"call dein#end()
"call dein#save_state()

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

set encoding=utf-8
let g:airline_powerline_fonts = 1

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

set clipboard=unnamedplus " copy to system clipboard

" Autocomplete with dictionary words
set complete+=kspell
