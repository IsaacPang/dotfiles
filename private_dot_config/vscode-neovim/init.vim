" --------------------------------------------------
" Plugins
" --------------------------------------------------
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
" Colour Scheme Plugins
" Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'rktjmp/lush.nvim'
" Plug 'ellisonleao/gruvbox.nvim'
" Plug 'arcticicestudio/nord-vim'

" Airline Plugins
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" Snippets
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

" tpope
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'

" Code Delights
Plug 'junegunn/vim-easy-align'
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'preservim/nerdtree'

" Fuzzy Finding
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'}

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
" --------------------------------------------------

" --------------------------------------------------
" tpope 
" --------------------------------------------------
"  vim-commentary
vmap <C-_> gc
nmap <C-_> gcc

" --------------------------------------------------

"" -------------------------------------------------- 
"" FZF
"" --------------------------------------------------
""  Open FZF with Ctrl + P
"nnoremap <C-p> :FZF<CR>
""  Actions to open files from fzf
"let g:fzf_action = {
"  \ 'ctrl-t': 'tab split',
"  \ 'ctrl-s': 'split',
"  \ 'ctrl-v': 'vsplit' }
"
"" colors for fzf
"let g:fzf_colors =
"\ { 'fg':      ['fg', 'Normal'],
"  \ 'bg':      ['bg', 'Normal'],
"  \ 'hl':      ['fg', 'Comment'],
"  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"  \ 'hl+':     ['fg', 'Statement'],
"  \ 'info':    ['fg', 'Type'],
"  \ 'border':  ['fg', 'Ignore'],
"  \ 'prompt':  ['fg', 'Character'],
"  \ 'pointer': ['fg', 'Exception'],
"  \ 'marker':  ['fg', 'Keyword'],
"  \ 'spinner': ['fg', 'Label'],
"  \ 'header':  ['fg', 'Comment'] }
"" -------------------------------------------------- 
"
"" -------------------------------------------------- 
"" NERDtree
"" -------------------------------------------------- 
"" open nerdtree with Alt + b
"nnoremap <A-b> :NERDTreeToggle<CR>
"
"" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
"autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
"    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
"
"" Automatically close nvim if NERDTree is the only thing left open
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"" -------------------------------------------------- 
"
"" -------------------------------------------------- 
"" Integrated Terminal
"" --------------------------------------------------
"" open terminal on Ctrl+n
"function! OpenTerminal()
"  split term://bash
"  resize 10
"endfunction
"nnoremap <C-n> :call OpenTerminal()<CR>
"
"" turn terminal to normal mode with escape
"tnoremap <Esc> <C-\><C-n>
"
"" start terminal in insert mode
"au BufEnter * if &buftype == 'terminal' | :startinsert | endif
"" -------------------------------------------------- 
"
"" -------------------------------------------------- 
"" COC
"" --------------------------------------------------
"" Give more space for displaying messages.
"set cmdheight=2
"
"" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
"" delays and poor user experience.
"set updatetime=300
"
"" Don't pass messages to |ins-completion-menu|.
"set shortmess+=c
"
"" Always show the signcolumn, otherwise it would shift the text each time
"" diagnostics appear/become resolved.
"if has("nvim-0.5.0") || has("patch-8.1.1564")
"  " Recently vim can merge signcolumn and number column into one
"  set signcolumn=number
"else
"  set signcolumn=yes
"endif
"
"" Use tab for trigger completion with characters ahead and navigate.
"" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
"" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"
"" Use <c-space> to trigger completion.
"if has('nvim')
"  inoremap <silent><expr> <c-space> coc#refresh()
"else
"  inoremap <silent><expr> <c-@> coc#refresh()
"endif
"" -------------------------------------------------- 
"
"" -------------------------------------------------- 
"" Airline
"" --------------------------------------------------
"let g:airline_theme='ayu_mirage'
"let g:airline_left_sep='>'
"let g:airline_right_set='|'
"let g:airline_powerline_fonts=1
"" -------------------------------------------------- 
"
"" -------------------------------------------------- 
"" Colour Schemes
"" -------------------------------------------------- 
"" Nord
"let g:nord_italic = 1
"let g:nord_italic_comments = 1
"colorscheme nord
"" " Gruvbox
"" let g:gruvbox_italic = 1
"" colorscheme gruvbox
"" " Dracula
"" augroup DraculaOverrides
""     autocmd!
""     autocmd ColorScheme dracula highlight DraculaBoundary guibg=none
""     autocmd ColorScheme dracula highlight DraculaDiffDelete ctermbg=none guibg=none
""     autocmd ColorScheme dracula highlight DraculaComment cterm=italic gui=italic
""     autocmd ColorScheme dracula call Adjust()
"" augroup end
"" -------------------------------------------------- 

" --------------------------------------------------
" General Settings
" --------------------------------------------------
let g:python3_host_prog = expand('~/miniconda3/bin/python3')
set relativenumber number
let mapleader=' '
let maplocalleader='\'
set nocompatible
filetype plugin on
syntax on
set noswapfile
set nobackup
set nowb
set binary
set termguicolors
set textwidth=100
set foldmethod=indent
set nofoldenable
set hidden
set noshowmode
set title
set splitbelow
set splitright
set ignorecase
set smartcase
set clipboard=unnamedplus
set softtabstop=2 tabstop=2 shiftwidth=2 expandtab
set ttimeoutlen=0
set showcmd
set scrolloff=5
" --------------------------------------------------

" --------------------------------------------------
" Autocommands
" --------------------------------------------------
" tabstops by filetype
autocmd FileType go set tabstop=2|set shiftwidth=2|set noexpandtab
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType yaml set tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType coffee set tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType sh set tabstop=2|set shiftwidth=2|set expandtab

" JSON comments matching
autocmd FileType json syntax match Comment +\/\/.\+$+
" --------------------------------------------------

" -------------------------------------------------- 
" Key mappings
" --------------------------------------------------

nnoremap k gk
nnoremap j gj
vnoremap k gk
vnoremap j gj

nnoremap Y y$

" Switch buffers
nnoremap <silent>H :silent bp<CR>
nnoremap <silent>L :silent bn<CR>

" Clear search
vnoremap < <gv
vnoremap > >gv

" inoremap kj <esc>
" cnoremap kj <C-C>

" Switch between splits
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j

" Switch between tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>


" Remove highlighting when exiting search
nnoremap <esc> :noh<return><esc>
" -------------------------------------------------- 
