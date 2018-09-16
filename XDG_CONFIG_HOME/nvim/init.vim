" Vim Plug
"
"
call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/vim-easy-align'

Plug 'scrooloose/nerdtree' 
" turn on Nerd tree when vim turned on
"autocmd vimenter * NERDTree | vertical resize 15 | wincmd p
map <C-n> :NERDTreeToggle<CR>
" Nerdtree behavior
let NERDTreeHighlightCursorline=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes'
" airline on. have any question? :help airline
set laststatus=1
" airline shows buffers as a tab
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

Plug 'vim-syntastic/syntastic'
let g:syntastic_check_on_open=1

"syntax
Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave=1

Plug 'elzr/vim-json'

Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'hdima/python-syntax'
Plug 'plasticboy/vim-markdown'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'fatih/vim-go'

"rails
Plug 'tpope/vim-rails'

" elixir
Plug 'elixir-editors/vim-elixir'

"colorschemes
Plug 'prognostic/plasticine'
Plug 'lu-ren/SerialExperimentsLain'
Plug 'hzchirs/vim-material'
Plug 'noahfrederick/vim-noctu'
Plug 'KeitaNakamura/neodark.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'dracula/vim',{'as':'dracula'}
Plug 'morhetz/gruvbox'

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
set directory=~/tmp/,./
set backupdir=~/tmp/,./
" jump to last position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
set background=dark
color gruvbox

" Fold
"
"
set foldmethod=syntax
set nofoldenable
set nofoldenable
set foldlevel=2

