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

" クリップボード設定をOSに応じて切り替え
if has('unix') && !has('macunix')
  " Linux and WSL
  set clipboard=unnamedplus
else
  " macOS and other systems
  set clipboard=unnamed
endif

" dein settings {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  echo "Installing dein.vim..."
  silent !git clone https://github.com/Shougo/dein.vim " . shellescape(s:dein_repo_dir)
  echo "Done."
endif

execute 'set runtimepath^=' . s:dein_repo_dir

" Dein.vimの初期化と設定
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  
  " dein.tomlを読み込む
  call dein#load_toml(expand('<sfile>:h') . '/dein.toml')
  
  " Dein.vimの終了処理
  call dein#end()
  call dein#save_state()
endif

" プラグインのインストールが必要な場合
if dein#check_install()
  call dein#install()
endif

" Required:
syntax enable

" deinコマンドの定義
command! DeinInstall call dein#install()
command! DeinUpdate call dein#update()
command! DeinClean call map(dein#check_clean(), "delete(v:val, 'rf')")
command! DeinRecache call dein#recache_runtimepath()
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
set backspace=indent,eol,start
set wildmenu

" leaderキーをspaceに設定
let mapleader = "\<Space>"

" .vimrcを開く
nnoremap <leader>. :edit $MYVIMRC<CR>



let g:airline#extension#tabline#enable = 1
" , キーで次タブのバッファを表示
"nnoremap <silent> , :bprev<CR>
" . キーで前タブのバッファを表示
"nnoremap <silent> . :bnext<CR>
" bdで現在のバッファを削除

""" unite.vim
"unite {{{


nnoremap bd :bd<CR>
"インサートモードで開始しない
let g:unite_enable_start_insert = 0
" バッファ一覧
nnoremap <silent> <leader>ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> <leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> <leader>ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> <leader>um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> <leader>uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> <leader>ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

"unite prefix key.
nnoremap [unite] <Nop>
nmap <Space>f [unite]

" For ack.
if executable('ack-grep')
  let g:unite_source_grep_command = 'ack-grep'
  let g:unite_source_grep_default_opts = '--no-heading --no-color -a'
  let g:unite_source_grep_recursive_opt = ''
endif

"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''

"data_directory はramdiskを指定
"if has('win32')
"  let g:unite_data_directory = 'Z:¥.unite'
"elseif  has('macunix')
"  let g:unite_data_directory = '/Volumes/RamDisk/.unite'
"else
"  let g:unite_data_directory = '/mnt/ramdisk/.unite'
"endif

"bookmarkだけホームディレクトリに保存
let g:unite_source_bookmark_directory = $HOME . '/.unite/bookmark'


"現在開いているファイルのディレクトリ下のファイル一覧。
"開いていない場合はカレントディレクトリ
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
"レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
"ブックマーク一覧
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
"ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
"uniteを開いている間のキーマッピング
augroup vimrc
  autocmd FileType unite call s:unite_my_settings()
augroup END
function! s:unite_my_settings()
  "ESCでuniteを終了
  nmap <buffer> <ESC> <Plug>(unite_exit)
  "入力モードのときjjでノーマルモードに移動
  imap <buffer> jj <Plug>(unite_insert_leave)
  "入力モードのときctrl+wでバックスラッシュも削除
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  "sでsplit
  nnoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
  inoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
  "vでvsplit
  nnoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
  inoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
  "fでvimfiler
  nnoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
  inoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
endfunction

"}}}

"vimfiler {{{

"data_directory はramdiskを指定
"if has('win32')
"  let g:vimfiler_data_directory = 'Z:¥.vimfiler'
"elseif  has('macunix')
"  let g:vimfiler_data_directory = '/Volumes/RamDisk/.vimfiler'
"else
"  let g:vimfiler_data_directory = '/mnt/ramdisk/.vimfiler'
"endif

" vimfiler の関連付けを実行
"call vimfiler#set_execute_file('vim', 'vim')
"call vimfiler#set_execute_file('txt', 'miw')

"vimデフォルトのエクスプローラをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1
"セーフモードを無効にした状態で起動する
let g:vimfiler_safe_mode_by_default = 0
"現在開いているバッファのディレクトリを開く
nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
"現在開いているバッファをIDE風に開く
nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>

" Edit file by tabedit.
let g:vimfiler_edit_action = 'tabopen'

"デフォルトのキーマッピングを変更
augroup vimrc
  autocmd FileType vimfiler call s:vimfiler_my_settings()
augroup END
function! s:vimfiler_my_settings()
  nmap <buffer> q <Plug>(vimfiler_exit)
  nmap <buffer> Q <Plug>(vimfiler_hide)
endfunction


"}}}

nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap ss :<C-u>sp<CR><C-w>j
nnoremap sv :<C-u>vs<CR><C-w>l

autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

" Previm
let g:previm_open_cmd = ''
nnoremap [previm] <Nop>
nmap <Space>p [previm]
nnoremap <silent> [previm]o :<C-u>PrevimOpen<CR>
nnoremap <silent> [previm]r :call previm#refresh()<CR>

" Catppuccin テーマ設定
set termguicolors

let g:airline_powerline_fonts = 1

" Catppuccin 設定

highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE
highlight Folded ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE

