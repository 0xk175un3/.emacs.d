" ---------------------------------------------------------------------------
"                           .vimrc of lainkun
" ---------------------------------------------------------------------------
" ---------------------------------------------------------------------------
"                                 plugins
" ---------------------------------------------------------------------------
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')
" ---------------------------------------------------------------------------
"                                   git
" ---------------------------------------------------------------------------
Plug 'tpope/vim-fugitive'

" ---------------------------------------------------------------------------
"                                  common
" ---------------------------------------------------------------------------
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-emoji'


" ---------------------------------------------------------------------------
"                                 browsing
" ---------------------------------------------------------------------------
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/vim-slash'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'yggdroot/indentline'
Plug 'majutsushi/tagbar'
Plug 'easymotion/vim-easymotion'


" ---------------------------------------------------------------------------
"                             languages support
" ---------------------------------------------------------------------------

" python
Plug 'hdima/python-syntax'
Plug 'klen/python-mode'
Plug 'nvie/vim-flake8'


" ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'bbatsov/rubocop'


" javascript / node
Plug 'pangloss/vim-javascript'
Plug 'moll/vim-node'
Plug 'marijnh/tern_for_vim', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript'
" js plug settings
let g:javascript_plugin_jsdoc = 1


" typescript
Plug 'leafgarland/typescript-vim'


" html
Plug 'othree/html5.vim'


" css/scss/less
Plug 'cakebaker/scss-syntax.vim'
Plug 'groenewege/vim-less'


" ---------------------------------------------------------------------------
"                               editor features
" ---------------------------------------------------------------------------
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction
Plug 'scrooloose/syntastic'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'honza/vim-snippets'
Plug 'mattn/emmet-vim'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
call plug#end()


" ---------------------------------------------------------------------------
"                                basic settings
" ---------------------------------------------------------------------------
language messages en_Us
syntax on
set tags=./tags;/
set number
set showcmd
set wildmenu
set lazyredraw
set showmatch
set backspace=indent,eol,start
set incsearch
set hlsearch
set hidden
set expandtab
set tabstop=2
set shiftwidth=2
set scrolloff=5
set nocursorline
set autoread
set nu
set visualbell
set encoding=utf-8
set list
set nostartofline
set statusline=%<[%n]\ %F\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %=%-14.(%l,%c%V%)\ %P

let g:tagbar_ctags_bin = '/usr/local/bin/ctags'

" ---------------------------------------------------------------------------
"                           Color theme settings
"
" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
" ---------------------------------------------------------------------------
let g:seoul256_background = 236
colo seoul256


" ---------------------------------------------------------------------------
"                                 mappings
" ---------------------------------------------------------------------------


" Basic mappings
let mapleader      = ' '
let maplocalleader = ' '
vnoremap <C-c> "*y
nmap <C-p> :FZF<CR>


" NERDtree toggle
nnoremap <F10> :NERDTreeToggle<cr>


" Tagbar toggle
nmap <F8> :TagbarToggle<CR>


" Easy Align key to format
nmap ga <Plug>(EasyAlign)


" Movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-^> <C-o><C-^>


" EasyMotion keys
nnoremap <leader>f :EasyMotion<cr>


" <tab> / <s-tab> | Circular windows navigation
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W


" Tern navigation
autocmd FileType javascript nnoremap <buffer> <silent> <C-]> :TernDef<CR>
autocmd CompleteDone * pclose


" jk | Escaping!
inoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>


" ---------------------------------------------------------------------------
"                               emoji settings
" ---------------------------------------------------------------------------
silent! if emoji#available()
  let s:ft_emoji = map({
    \ 'c':          'baby_chick',
    \ 'clojure':    'lollipop',
    \ 'coffee':     'coffee',
    \ 'cpp':        'chicken',
    \ 'css':        'art',
    \ 'eruby':      'ring',
    \ 'gitcommit':  'soon',
    \ 'haml':       'hammer',
    \ 'help':       'angel',
    \ 'html':       'herb',
    \ 'java':       'older_man',
    \ 'javascript': 'monkey',
    \ 'make':       'seedling',
    \ 'markdown':   'book',
    \ 'perl':       'camel',
    \ 'python':     'snake',
    \ 'ruby':       'gem',
    \ 'scala':      'barber',
    \ 'sh':         'shell',
    \ 'slim':       'dancer',
    \ 'text':       'books',
    \ 'vim':        'poop',
    \ 'vim-plug':   'electric_plug',
    \ 'yaml':       'yum',
    \ 'yaml.jinja': 'yum'
  \ }, 'emoji#for(v:val)')

  function! S_filetype()
    if empty(&filetype)
      return emoji#for('grey_question')
    else
      return get(s:ft_emoji, &filetype, '['.&filetype.']')
    endif
  endfunction

  function! S_modified()
    if &modified
      return emoji#for('kiss').' '
    elseif !&modifiable
      return emoji#for('construction').' '
    else
      return ''
    endif
  endfunction

  function! S_fugitive()
    if !exists('g:loaded_fugitive')
      return ''
    endif
    let head = fugitive#head()
    if empty(head)
      return ''
    else
      return head == 'master' ? emoji#for('crown') : emoji#for('dango').'='.head
    endif
  endfunction

  let s:braille = split('"⠉⠒⠤⣀', '\zs')
  function! Braille()
    let len = len(s:braille)
    let [cur, max] = [line('.'), line('$')]
    let pos  = min([len * (cur - 1) / max([1, max - 1]), len - 1])
    return s:braille[pos]
  endfunction

  hi def link User1 TablineFill
  let s:cherry = emoji#for('cherry_blossom')
  function! MyStatusLine()
    let mod = '%{S_modified()}'
    let ro  = "%{&readonly ? emoji#for('lock') . ' ' : ''}"
    let ft  = '%{S_filetype()}'
    let fug = ' %{S_fugitive()}'
    let sep = ' %= '
    let pos = ' %l,%c%V '
    let pct = ' %P '

    return s:cherry.' [%n] %F %<'.mod.ro.ft.fug.sep.pos.'%{Braille()}%*'.pct.s:cherry
  endfunction

  " Note that the "%!" expression is evaluated in the context of the
  " current window and buffer, while %{} items are evaluated in the
  " context of the window that the statusline belongs to.
  set statusline=%!MyStatusLine()
endif
