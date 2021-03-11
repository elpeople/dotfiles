" 互換の動きにしない
set nocompatible

" 日本語のヘルプ → 英語のヘルプの順に検索
set helplang=ja,en

" :help
:nnoremap <C-h> :<C-u>h<Space>

" キーコードやマッピングされたキー列が完了するのを待つ時間(ミリ秒)
 set timeout timeoutlen=3000 ttimeoutlen=100

" 左右のカーソル移動で行間移動可能にする。
set whichwrap=b,s,<,>,[,]

"挿入モード終了時にIME状態を保存しない
inoremap <silent> <Esc> <ESC>
inoremap <silent> <C-[> <ESC>

"日本語ード固定入力モード
inoremap <silent> <C-j> <C-^>

" バッファをキーで移動
map <F2> <ESC>:bp<CR>
map <F3> <ESC>:bn<CR>
" バッファ関連
"編集中でもバッファを切り替えれるようにしておく
set hidden
" バッファ一覧ショートカット→バッファ番号で移動
nmap gb :ls<CR>:buf
"nmap <Space>b :ls<CR>:buffer
"namp <Space>f :edit .<CR>
nmap <Space>v :vsplit<CR><C-w><C-w>:ls<CR>:buffer
nmap <Space>V :Vexplore!<CR><CR>

" ---  ファイラーを起動 ---
nnoremap <silent><Space>j    :Explore<CR>
" 前のバッファ、次のバッファ、バッファの削除、バッファのリスト
nnoremap <silent><Space>b    :bp<CR>
nnoremap <silent><Space>n    :bn<CR>
nnoremap <silent><Space>k    :bd<CR>
nnoremap <Space>o    <C-W>o               " カーソルのあるウインドウを最大化する
nnoremap <silent><Space>h    :hide<CR>    " カーソルのあるウインドウを隠す
nnoremap <silent><Space>l    :Bufferlist<CR>
" ファイル保存：バッファ変更時のみ保存
nnoremap <silent><Space>s    :<C-u>update<CR>

" 最近開いたファイル MRU
nnoremap <silent><Space>m  :MRU<CR>
let MRU_Auto_Close = 0

""buffer
"nnoremap <C-j> <C-^>
"let buftabs_only_basename = 1
"let buftabs_in_statusline = 1
"nnoremap <C-j> :<C-u>BufExplorer<Enter>

" 見た目で行移動
nnoremap j gj
nnoremap k gk

" 行の折り返し
nnoremap <Leader>w  :set wrap!<CR>

"ファイルのタブ設定
nnoremap <S-Tab> gt
nnoremap <C-S-Tab> gT

" 削除でレジスタに格納しない(ビジュアルモードでの選択後は格納する)
nnoremap x "_x
nnoremap dd "_dd

" コマンドモードでemacs風キーバインドにする
cmap <C-f> <Right>
cmap <C-b> <Left>
cmap <C-a> <Home>
cmap <C-e> <End>
cmap <C-d> <Del>
cmap <C-h> <BackSpace>

" 選択部分をクリップボードにコピー
"vmap <C-C> "*y
" Ctrl+Vで貼り付け
"nmap <C-V> "*pa<ESC>
" 挿入モード時、クリップボードから貼り付け
"imap <C-V> <ESC>"*pa
" 選択部分をクリップボードの値に置き換え
"vmap <C-V> d"*P
" コマンドライン時、クリップボードから貼り付け
"cmap <C-V> <C-R>*
" 選択部分をクリップボードに切り取り
"vmap <C-X> "*d<ESC>
" ビジュアルモード中削除キーで範囲削除
"vmap <BS> d
"vmap <Delete> d

"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase
" 検索を循環させない
set nowrapscan

"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
"set nobackup
"スワップファイル用のディレクトリ
set backup
set backupdir=~/.vimbackup
"set directory=$HOME/vimbackup

" スワップファイルを作成しない
"set noswapfile
set swapfile
set directory=~/.vimswap

" 無限undoと編集位置の自動復帰
if has('persistent_undo')
	set undodir=~/vimfiles/undo
	set undofile
endif

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\""
"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を表示 (number:表示)
set number
" ルーラーを表示 (noruler:非表示)
set ruler
"set title
" タブや改行を表示 (list:表示)
set nolist
" どの文字でタブや改行を表示するかを設定(表示しないように)
"set listchars=
 set list listchars=tab:>-,extends:<,trail:_,eol:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表
set showcmd
" タイトルバーの表示を消す
set notitle

"---------------------------------------------------------------------------
" 編集に関する設定:
" インデントの設定
set cindent
" タブの画面上での幅
set tabstop=4
set softtabstop=4
set shiftwidth=4
" タブをスペースに展開しない (expandtab:展開する)
set noexpandtab
"タブを空白で入力する
"set expandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=2
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" 対応括弧の瞬間強調時間
set matchtime=3
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" 日本語整形スクリプト(by. 西岡拓洋さん)用の設定
let format_allow_over_tw = 1    " ぶら下り可能幅

"水平タブ系の設定==============================================
"デフォルト設定。結局runtime/indentの設定のほうで、ファイルごとに切り替える
" タブとか改行を表示する
set list

" タブとか改行を示す文字列 eol(改行)は背景色違いのスペースにする。
set listchars=tab:>-,extends:<,trail:-,eol:\  

"実はスマートはウザかったりする。
"set smartindent

"空行のインデントを勝手に消さない
nnoremap o oX<C-h>
nnoremap O OX<C-h>
inoremap <CR> <CR>X<C-h>

" 文字コード関連
" 文字コードの自動解釈の優先順位
set fileencodings=utf-8,cp932,euc-jp
" 改行コードの解釈優先順位
set fileformats=unix,dos

" 内部の解釈の文字コード　設定ファイルもこのコードで書け
"set encoding=utf-8
" 内部の改行コード
set fileformat=unix

"---------------------------------------------------------------------------
" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags=./tags,tags
endif

"---------------------------------------------------------------------------
" プラットホーム依存の特別な設定
"---------------------------------------------------------------------------
" OS毎に.vimの読み込み先を変える{{{
"---------------------------------------------------------------------------
"if has('win32')
" :let $VIMFILE_DIR = 'vimfiles'
"else
" :let $VIMFILE_DIR = '.vim'
"endif
" ~ こっから先、~/.vimを参照する場合、代わりに、~/.$VIMFILE_DIR と書くこと!
"}}}

" WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mac')
  " Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
  set iskeyword=@,48-57,_,128-167,224-235
endif

" 自分で追加↓
" ヤンク/pでクリップボード操作
" ヤンクをクリップボードへ送り込む
set clipboard+=unnamed

" :browse の初期ディレクトリ(vimエディタで開いているファイルと同じディレクトリ)
set browsedir=buffer

syntax on
filetype on

" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=cp932
  set fileencoding=cp932
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=dos,unix,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif
" 改行コードの自動認識
set fileformats=dos,unix,mac

" 全角スペース、末尾の半角スペース、タブを色づけする(色は俺好み、でも全角スペースを□にしたい)
if has("syntax")
    syntax on
    function! ActivateInvisibleIndicator()
        syntax match InvisibleJISX0208Space "　" display containedin=ALL
        highlight InvisibleJISX0208Space term=underline ctermbg=Blue guifg=#999999 gui=underline
        syntax match InvisibleTrailedSpace "[ ]\+$" display containedin=ALL
        highlight InvisibleTrailedSpace term=underline ctermbg=Red guifg=#FF5555 gui=underline
        syntax match InvisibleTab "\t" display containedin=ALL
        highlight InvisibleTab term=underline ctermbg=Cyan guibg=#555555 
    endf

    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif

" ==================================================================

"全角スペースを視覚化
"if has('syntax')
"  syntax enable
"  function! ActivateInvisibleIndicator()
"    highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=#FF0000
"    match ZenkakuSpace /　/
"  endfunction
"  augroup InvisibleIndicator
"    autocmd!
"    autocmd BufEnter * call ActivateInvisibleIndicator()
"  augroup END
"endif

" ステータスエリア関係
"ステータスのところにファイル情報表示
"set statusline=%<[%n]%F%=\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}\ %l,%c\ %P 
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" ビジュアルモードの矩形選択時に仮想編集できるようにする。
set virtualedit+=block

"escでハイライトをオフ
nnoremap <silent> <ESC> <ESC>:noh<CR>
" ノーマルモード中でもエンターキーで改行挿入でノーマルモードに戻る
noremap <CR> i<CR><ESC>

" 挿入モードでctrl+T二回うちで現在時刻挿入
imap <silent> <C-T><C-T> <C-R>=strftime("%H:%M:%S")<CR>

" full, longest, list
" (C-dでも一覧表示される)
 set wildmode=list,full
" set wildmode=longest:full,full
" set wildmode=longest,full
" set wildmode=longest,list
" set wildmode=list:full
" set wildmode=list:longest

" .vimrcを開く
nnoremap <Space>.  :<C-u>edit $MYVIMRC<CR>
" source ~/.vimrc を実行する。
nnoremap <Space>,  :<C-u>source $MYVIMRC<CR> 

" neobundle {{{
"set nocompatible               " Be iMproved
"filetype off                   " Required!

"if has('vim_starting')
"  set runtimepath+=~/vimfiles/bundle/neobundle.vim/
"endif

"call neobundle#rc(expand('~/vimfiles/bundle/'))

"filetype plugin indent on

" Installation check.
" A
" if neobundle#exists_not_installed_bundles()
"   echomsg 'Not installed bundles : ' .
"         \ string(neobundle#get_not_installed_bundle_names())
"   echomsg 'Please execute ":NeoBundleInstall" command.'
   "finish
"endif

"NeoBundleを利用する際には始まる前に記載しておく

"if has('vim_starting')
"    set runtimepath+=~/.vim/bundle/neobundle.vim/
"    if has('win32')
"        set runtimepath^=~/.vim/
"    endif
"    call neobundle#rc(expand('~/.vim/bundle/'))
"endif
"runtimepathはただのパスの追加です。
"Windowsの場合はvimfilesを参照したがるので.vimを
"参照する場合は先頭に追加するために^=で指定してやる
"neobundle#rcはneobundleで管理するプラグインの保存場所と考えて

"let g:neobundle_default_git_protocol='https'
"NeoBundle 'vim-jp/vimdoc-ja'
"NeoBundle 'Shougo/vimfiler'
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'Shougo/vimproc'
"NeoBundle 'Shougo/vimshell'
"NeoBundle 'Shougo/neocomplcache'
"NeoBundle 'Shougo/neocomplcache-snippets-complete'
"NeoBundle 'Shougo/neosnippet'
"NeoBundle 'tpope/vim-surround'
"NeoBundle 'tpope/vim-rails'
"NeoBundle 'tpope/vim-haml'
"NeoBundle 'thinca/vim-ref'
"NeoBundle 'soh335/vim-alc'
"NeoBundle 'tokuhirom/jsref'
"NeoBundle 'soh335/vim-ref-jquery'
"NeoBundle 'soh335/vim-ref-pman'
"NeoBundle 'ujihisa/ref-hoogle'
"NeoBundle 'pekepeke/ref-javadoc'
"NeoBundle 'mojako/ref-sources.vim'
"NeoBundle 'soh335/vim-ref-jquery'
"NeoBundle 'nodejsjp/nodejs.org_ja'
"NeoBundle 'thinca/vim-quickrun'
"NeoBundle 'thinca/vim-fontzoom'
"NeoBundle 'thinca/vim-singleton'
"NeoBundle 'tsaleh/vim-matchit'
"NeoBundle 'tsaleh/vim-align'
"NeoBundle 'h1mesuke/vim-alignta'
"NeoBundle 'h1mesuke/unite-outline'
"NeoBundle 'vim-scripts/yanktmp.vim'
"NeoBundle 'vim-scripts/svn-diff.vim'
"NeoBundle 'basyura/TweetVim'
"NeoBundle 'basyura/twibill.vim'
"NeoBundle 'basyura/bitly.vim'
"NeoBundle 'hrp/EnhancedCommentify'
"NeoBundle 'janx/vim-rubytest'
"NeoBundle 'three/eregex.vim'
"NeoBundle 'vim-ruby/vim-ruby'
"NeoBundle 'koron/chalice'
"NeoBundle 'mattn/webapi-vim'
"NeoBundle 'tyru/open-browser.vim'
"NeoBundle 'hotchpotch/perldoc-vim'
"NeoBundle 'c9s/perlomni.vim'
"NeoBundle 'fs111/pydoc.vim'
"NeoBundle 'godlygeek/tabular'
"NeoBundle 'superbrothers/vim-vimperator'
"NeoBundle 'kakkyz81/evervim'
"NeoBundle 'yuratomo/w3m.vim'
"NeoBundle 'jiangmiao/simple-javascript-indenter'
"NeoBundle 'jelera/vim-javascript-syntax'
"NeoBundle 'teramako/jscomplete-vim'
"NeoBundle 'scrooloose/syntastic'
"NeoBundle 'basyura/jslint.vim'
"NeoBundle 'yuratomo/gmail.vim'
"NeoBundle 'vim-scripts/visSum.vim'
"NeoBundle 'mattn/excitetranslate-vim'
"NeoBundle 'davidoc/taskpaper.vim'
"NeoBundle 'mattn/emmet-vim'
"NeoBundle 'mattn/webapi-vim'
"NeoBundle 'hail2u/vim-css3-syntax'
"NeoBundle 'taichouchou2/html5.vim'
"NeoBundle 'taichouchou2/vim-javascript'
"NeoBundle 'kchmck/vim-coffee-script'
"NeoBundle 'petdance/vim-perl'

"NeoBundleで管理するプラグイン達
"githubにある場合は'ユーザ名/リポジトリ'で
"無い場合は'リポジトリ'で管理する。
"g:neobundle_default_git_protocolはhttpsを
"利用する場合はこのように設定する

"filetype plugin on
"filetype indent on
"上でオフにしたものをオンに戻す

 " ...
" filetype plugin indent on     " Required!
 "
 " Brief help
 " :NeoBundleList          - list configured bundles
 " :NeoBundleInstall(!)    - install(update) bundles
 " :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

 " Installation check.
" if neobundle#exists_not_installed_bundles()
"   echomsg 'Not installed bundles : ' .
"         \ string(neobundle#get_not_installed_bundle_names())
"   echomsg 'Please execute ":NeoBundleInstall" command.'
   "finish
" endif

	" }}}

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('$HOME/.cache/dein')
  call dein#begin('$HOME/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('$HOME/.cache/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/vimproc.vim',{'build' : 'make'})
call dein#add('Shougo/vimshell')
call dein#add('Shougo/vimfiler')
call dein#add('Shougo/unite.vim')
call dein#add('basyura/TweetVim')
call dein#add('mattn/webapi-vim')
call dein#add('basyura/twibill.vim')
call dein#add('tyru/open-browser.vim')
call dein#add('h1mesuke/unite-outline')
call dein#add('basyura/bitly.vim')
call dein#add('davidoc/taskpaper.vim')
call dein#add('yuratomo/gmail.vim')

" You can specify revision/branch/tag.
call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })

" Required:
call dein#end()
call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
   call dein#install()
endif

"End dein Scripts-------------------------))))

"  call dein#add('Shougo/vimshell')
"  call dein#add('Shougo/vimproc')



"    dein#add('yuratomo/w3m.vim')
"  call dein#add('kakkyz81/evervim')

"  call dein#add('davidoc/taskpaper.vim')

" You can specify revision/branch/tag.
"  call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })

 "vimproc
let g:vimproc#download_windows_dll = 1

 " neocomplcache
let g:neocomplcache_enable_at_startup = 1

" qfixmemo
" qfixappにruntimepathを通す(パスは環境に合わせてください)
set runtimepath+=c:/bin/gvim/qfixapp

" キーマップリーダー
let QFixHowm_Key = 'g'

" howm_dirはファイルを保存したいディレクトリを設定
let howm_dir             = 'c:/bin/home/howm'
let howm_filename        = '%Y/%m/%Y-%m-%d-%H%M%S.txt'
let howm_fileencoding    = 'cp932'
let howm_fileformat      = 'dos'

""" unite.vim
"unite {{{

"インサートモードで開始しない
let g:unite_enable_start_insert = 0
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

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
"  let g:unite_data_directory = 'Z:\.unite'
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
"  let g:vimfiler_data_directory = 'Z:\.vimfiler'
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

" ref.vim   {{{
nmap ,ra :<C-u>Ref alc<Space>

let g:ref_alc_start_linenumber = 39 " 表示する行数
let g:ref_alc_encoding = 'Shift-JIS' " 文字化けするならここで文字コードを指定してみ

let g:ref_phpmanual_path = $HOME . '/Doc/phpmanual'

" for Utl
nnoremap <silent> <cr> :silent exe 'Utl'<cr><cr> 
"URL を Firefox で開く(URLが含まれる行で \gu ）
let g:utl_cfg_hdl_scm_http = 'silent !start D:\Program Files\Mozilla Firefox\firefox.exe %u'
"ディレクトリをあふで開く（ :Gu . でカレントディレクトリを開ける）
let g:utl_mt_text_directory = ':!start C:\bin\home\afxw\AFXCMD.EXE -L"%P\"'

" afx.exeのパスを指定する部分は環境に応じて適宜設定する
noremap <silent> <F11> :exe '!start' expand('c:/bin/afxw/AFXW.EXE') '-s "-p%:p"'<cr>

" Evervim
let g:evervim_devtoken='S=s29:U=317c2d:E=1423cc56186:C=13ae5143586:P=1cd:A=en-devtoken:H=b99bbfec718c2cb486d673c6fca7070a'

" w3m.vim
let g:w3m#command = 'C:\\bin\\home\\w3m\\w3m.exe'

" この設定入れるとshiftwidthを1にしてインデントしてくれる
let g:SimpleJsIndenter_BriefMode = 1
" この設定入れるとswitchのインデントがいくらかマシに
let g:SimpleJsIndenter_CaseIndentLevel = -1

" Syntax file for jQuery
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

" DOMとMozilla関連とES6のメソッドを補完
let g:jscomplete_use = ['dom', 'moz', 'es6th']
" このようにするとjshintを必ず使ってチェックしてくれるようになる
let g:syntastic_javascript_checker = "jshint"

"Gmail
"ユーザー名の設定
let g:gmail_user_name = 'elpeoplegm@gmail.com'
"メール送信時の署名
let g:gmail_signature = '# ' . g:gmail_user_name . '(by gmail.vim)'

" visSum.vim
nmap <Leader>sp "sp

"ディレクトリの自動移動
au BufEnter * execute ":lcd " . expand("%:p:h")

" Capture {{{
command!
      \ -nargs=+ -bang
      \ -complete=command
      \ Capture
      \ call s:cmd_capture([<f-args>], <bang>0)

function! C(cmd)
  redir => result
  silent execute a:cmd
  redir END
  return result
endfunction

function! s:cmd_capture(args, banged) "{{{
  new
  silent put =C(join(a:args))
  1,2delete _
endfunction "}}}
" }}}

" ウィンドウを閉じずにバッファを閉じる
command! Ebd call EBufdelete()
function! EBufdelete()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif

  if buflisted(l:currentBufNum)
    execute "silent bwipeout".l:currentBufNum
    " bwipeoutに失敗した場合はウインドウ上のバッファを復元
    if bufloaded(l:currentBufNum) != 0
      execute "buffer " . l:currentBufNum
    endif
  endif
endfunction

" カーソルを自動的に()の中へ
imap {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap "" ""<Left>
imap '' ''<Left>
imap <> <><Left>
imap // //<left>
imap /// ///<left>

" open-browser.vim
nmap gW <Plug>(openbrowser-open)

" qtmplsel.vim
"let g:qts_templatedir='(テンプレートファイル格納先フォルダ)'

" str2htmlentity.vim
vmap <silent> sx :Str2HtmlEntity<cr>
vmap <silent> sr :Entity2HtmlString<cr>

"emmet
 let g:user_emmet_mode = 'iv'
let g:user_emmet_leader_key = '<C-Y>'
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
\ 'lang' : 'ja',
\ 'html' : {
\ 'filters' : 'html',
\ },
\ 'css' : {
\ 'filters' : 'fc',
\ },
\ 'php' : {
\ 'extends' : 'html',
\ 'filters' : 'html',
\ },
\}
augroup EmmitVim
autocmd!
autocmd FileType * let g:user_emmet_settings.indentation = ' '[:&tabstop]
augroup END

" Template
"autocmd BufNewFile *.pl 0r $HOME/.vim/template/perl.txt
autocmd BufNewFile *.html 0r ~/.vim/template/html.txt

" quickrun.vim
nmap <Leader>r <plug>(quickrun)

" perlの設定
augroup filetypedetect
autocmd! BufNewFile,BufRead *.t setf perl
autocmd! BufNewFile,BufRead *.psgi setf perl
autocmd! BufNewFile,BufRead *.tt setf tt2html
augroup END

autocmd BufNewFile *.pl 0r $HOME/.vim/template/perl-script.txt
autocmd BufNewFile *.t  0r $HOME/.vim/template/perl-test.txt

" PluginTest
"command! -bang -nargs=* PluginTest call PluginTest(<bang>0, <q-args>)
"
"function! PluginTest(is_gui, extraCommand)
"  let cmd = a:is_gui ? 'gvim' : 'vim'
"  let extraCommand = empty(a:extraCommand) ? '' : ' -c"au VimEnter * ' . a:extraCommand . '"'
"  execute '!' . cmd . ' -u ~/.vim/.min.vimrc -i NONE -N --cmd "set rtp+=' . getcwd() . '"' . extraCommand
"endfunction
""}}}

" vimの常駐
" call singleton#enable()
