" --------------------------------------------------
" General Settings
" --------------------------------------------------
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
