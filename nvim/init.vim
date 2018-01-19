" ==========================================================================================================
"                                         Configure Plugins
" ==========================================================================================================

silent! if plug#begin('~/.config/nvim/plugged')

let g:plug_url_format = 'git@github.com:%s.git'

" ===== Langnuage support =====
Plug 'tpope/vim-markdown'
Plug 'honza/dockerfile.vim'
Plug 'vim-syntastic/syntastic'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'

" HTML, CSS etc
Plug 'groenewege/vim-less'
Plug 'digitaltoad/vim-jade'
Plug 'mustache/vim-mustache-handlebars'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-haml'

" Haskell
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }
Plug 'pbrisbin/vim-syntax-shakespeare'
Plug 'parsonsmatt/intero-neovim', { 'for': 'haskell' }
let g:haskell_classic_highlighting = 1
let g:haskell_indent_if = 4
let g:haskell_indent_case = 4
let g:haskell_indent_in = 0

" Javascript
Plug 'elzr/vim-json'
Plug 'moll/vim-node', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'kchmck/vim-coffee-script'

" ===== Colors and UI awesome things =====
set guifont=Droid\ Sans\ Mono\ 15
Plug 'flazz/vim-colorschemes'
Plug 'rakr/vim-one'
colorscheme one-dark
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#left_sep = '|'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_theme = 'one-dark'

" ===== Editing =====
Plug 'tpope/vim-surround'                              " Better support for working with things that 'surround' text such as quotes and parens
Plug 'tpope/vim-commentary'                            " Easily comment/uncomment code
Plug 'tpope/vim-endwise'                               " Automatically inserts `end` for you. Convenient, works well
Plug 'junegunn/vim-easy-align'                         "
Plug 'Shougo/deoplete.nvim'                            " Autocomplete
let g:deoplete#enable_at_startup = 1
Plug 'alvan/vim-closetag'
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
autocmd! User indentLine doautocmd indentLine Syntax

" ===== Git =====
Plug 'tpope/vim-fugitive'                              " Git integration... I should learn this better

" ===== Browsing =====
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " Tree Display for the file system
augroup nerd_loader
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
        \  if isdirectory(expand('<amatch>'))
        \|   call plug#load('nerdtree')
        \|   execute 'autocmd! nerd_loader'
        \| endif
augroup END

call plug#end()
endif

" ==========================================================================================================
"                                         Configure Basics
" ==========================================================================================================

" ===== Smallest Viable Configuration =====
filetype plugin on                   " Load code that configures vim to work better with whatever we're editing
filetype indent on                   " Load code that lets vim know when to indent our cursor
syntax on                            " Turn on syntax highlighting
set nocompatible                     " Behave more usefully at the expense of backwards compatibility (this line comes first b/c it alters how the others work)
set encoding=utf-8                   " Format of the text in our files (prob not necessary, but should prevent weird errors)
set gcr=a:blinkon0                   " Disable cursor blink
set relativenumber                   " Numbers follow you!
set backspace=indent,eol,start       " backspace through everything in insert mode
set expandtab                        " When I press tab, insert spaces instead
set shiftwidth=2                     " Specifically, insert 2 spaces
set tabstop=2                        " When displaying tabs already in the file, display them with a width of 2 spaces
set softtabstop=2
set autoindent
set smartindent
set smarttab
set list listchars=tab:\ \ ,trail:·  " Display tabs and trailing spaces visually
set linebreak                        " Wrap lines at convenient points
set completeopt=longest,menuone
set wildmenu
set visualbell
set noerrorbells
set novisualbell

" ===== Instead of backing up files, just reload the buffer when it changes =====
set autoread                         " Auto-reload buffers when file changed on disk
set nobackup                         " Don't use backup files
set nowritebackup                    " Don't backup the file while editing
set noswapfile                       " Don't create swapfiles for new buffers
set updatecount=0                    " Don't try to write swapfiles after some number of updates
set backupskip=/tmp/*,/private/tmp/* " Let me edit crontab files

" ===== Aesthetics =====
set t_Co=256                         " Explicitly tell vim that the terminal supports 256 colors (iTerm2 does, )
set background=dark                  " Tell vim to use colours that works with a dark terminal background (opposite is 'light')
set nowrap                           " Display long lines as truncated instead of wrapped onto the next line
set re=1                             " Use an older regex library that is much much quicker
set number                           " Show line numbers
set hlsearch                         " Highlight all search matches that are on the screen
set showcmd                          " Display info known about the command being edited (eg number of lines highlighted in visual mode)
" set colorcolumn=80                   " Add a column at the 80 char mark, for visual reference

" ===== Basic behaviour =====
set scrolloff=4                      " Scroll away from the cursor when I get too close to the edge of the screen
set incsearch                        " Incremental searching
set hlsearch                         " Highlight searches by default
set ignorecase                       " Ignore case when searching...
set smartcase                        " ...unless we type a capital

" ===== Folds =====
set foldmethod=indent                "fold based on indent
set foldnestmax=3                    "deepest fold is 3 levels
set nofoldenable                     "dont fold by default

" ===== Whitespace =====
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()  " strip trailing whitespace on save

" ==========================================================================================================
"                                         Configure Keybinding
" ==========================================================================================================
let mapleader=" "

" ===== jk | Escaping! =====
inoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>

" ===== <F10> | NERD Tree =====
nnoremap <F10> :NERDTreeToggle<cr>

" ===== Quicker window movement =====
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" ===== EasyAlign keybindings =====
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
