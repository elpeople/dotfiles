if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" vimの永続undo
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

set clipboard=unnamedplus

" dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}

" プラグイン以外のその他設定が続く
" :

" netrwの有効化
"filetype plugin on

" default filer
let g:vimfiler_as_default_explorer = 1
" ★vimの基本設定
set number
set relativenumber
set title
set paste
set ambiwidth=double
set tabstop=2
set expandtab
set hlsearch
set ignorecase
set incsearch
set smartcase
set laststatus=2
syntax on
set autoindent
filetype plugin indent on
set showcmd
set ruler
set cursorline
set showmatch
set shiftwidth=2
set smartindent
" set list
" set nrformats-=octal
" set hidden
" set history=50
" set virtualedit=block
" set whichwrap=b,s,[,],<,>
" set backspace=indent,eol,start
set wildmenu

" .vimrcを開く
nnoremap <space>. :edit $MYVIMRC<CR>

augroup TransparentBG
autocmd!
autocmd Colorscheme * highlight Normal ctermbg=none
autocmd Colorscheme * highlight NonText ctermbg=none
autocmd Colorscheme * highlight LineNr ctermbg=none
autocmd Colorscheme * highlight Folded ctermbg=none
autocmd Colorscheme * highlight EndOfBuffer ctermbg=none
augroup END

let g:airline#extension#tabline#enable = 1
" , キーで次タブのバッファを表示
"nnoremap <silent> , :bprev<CR>
" . キーで前タブのバッファを表示
"nnoremap <silent> . :bnext<CR>
" bdで現在のバッファを削除
nnoremap bd :bd<CR>


nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap ss :<C-u>sp<CR><C-w>j
nnoremap sv :<C-u>vs<CR><C-w>l
