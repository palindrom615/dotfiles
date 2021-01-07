" Vim Plug
"
"
call plug#begin('~/.local/share/nvim/plugged')

" auto indent
Plug 'tpope/vim-sleuth'
" git support
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" fzf
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" nerdtree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" turn on Nerd tree when vim turned on
" autocmd vimenter * NERDTree | vertical resize 15 | wincmd p
map <C-n> :NERDTreeToggle<CR>
" Nerdtree behavior
let NERDTreeHighlightCursorline=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes'
" airline on. have any question? :help airline
set laststatus=2
" airline shows buffers as a tab
let g:airline#extensions#tabline#enabled=1
"let g:airline_theme='base16'
" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1


Plug 'editorconfig/editorconfig-vim'

" language server support
Plug 'w0rp/ale'
let g:ale_completion_enabled = 1
" Error and warning signs.

"colorschemes
"Plug 'prognostic/plasticine'
"Plug 'lu-ren/SerialExperimentsLain'
"Plug 'hzchirs/vim-material'
"Plug 'noahfrederick/vim-noctu'
"Plug 'KeitaNakamura/neodark.vim'
"Plug 'NLKNguyen/papercolor-theme'
"Plug 'dracula/vim',{'as':'dracula'}
"Plug 'morhetz/gruvbox'
"Plug 'twerth/ir_black'
"Plug 'chriskempson/base16-vim'
"Plug 'joshdick/onedark.vim'
"Plug 'baskerville/bubblegum'
"Plug 'dikiaap/minimalist'
call plug#end()

" General Settings
"
"
syntax on
filetype plugin indent on
set autoindent 
set number 
set hlsearch 
set cursorline " line highlight
set cursorcolumn
set visualbell
set history=10000
set encoding=utf-8
set fileencodings=utf-8
set fileformat=unix " for linefeeding
set ignorecase	" ignore case when searching
set showmatch	" highlight matched quote
set mouse=a " sane mouse scrolling
"swp file location 
set directory=/tmp/,./
set backupdir=/tmp/,./
" jump to last position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set termguicolors 
"color base16-default-dark

" Fold
"
"
set foldmethod=syntax
set nofoldenable
set foldlevel=2

