" ============================================================================
" PORTABLE VIMRC (Server Mirror)
" This file is designed to be copied to a remote server as ~/.vimrc
" ============================================================================

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nocompatible
filetype off
syntax on
filetype plugin indent on

let mapleader = ","
let maplocalleader = ","

call plug#begin()
Plug 'lervag/vimtex'
Plug 'morhetz/gruvbox'
Plug 'raivivek/vim-snakemake'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" Options
set modelines=0
set number
set relativenumber
set ruler
set visualbell
set encoding=utf-8
set wrap
set textwidth=0
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:>
set hidden
set laststatus=2
set showmode
set showcmd
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set termguicolors
set background=dark

" Keymaps
nnoremap j gj
nnoremap k gk
nnoremap / /\v
vnoremap / /\v
map <leader><space> :let @/=''<cr>

" FZF mappings
nnoremap <Tab> :Buffers<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>r :Rg!<CR>

" Buffer navigation
nnoremap gn :bn<CR>
nnoremap gp :bp<CR>

" Search/Replace
nnoremap <leader>sr :%s/<C-R><C-W>//g<Left><Left>

" Colorscheme
silent! colorscheme gruvbox
