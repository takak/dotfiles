set nocompatible      " vi互換無効化

" ----------------------------------------------
" エンコード関連
" ----------------------------------------------
set encoding=utf-8    " ファイル読み込み時の文字コードの設定
scriptencoding utf-8  " Vim script内でマルチバイト文字を使う場合の設定
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決

" ----------------------------------------------
" vundle
" ----------------------------------------------
filetype off
"set rtp+=~/.vim/vundle.git/ " github管理仕様 set rtp+=~/.vim/vundle.git/
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" プラグイン
"" カラースキーム
Bundle 'xoria256.vim'
"" syntax
Bundle 'peitalin/vim-jsx-typescript'
Bundle 'tpope/vim-rails'
Bundle 'hashivim/vim-terraform'
" statuslineの拡張
Bundle 'itchyny/lightline.vim'
" 末尾の半角と全角スペースの可視化
Bundle 'bronson/vim-trailing-whitespace'
" 入力補完
" Vundleはブランチ指定ができず、masterにはビルド済みのbuild/index.jsが無いため
" releaseブランチを手動でcloneし、Vundleの更新対象から外す(READMEを参照)
Bundle 'neoclide/coc.nvim', {'pinned': 1}

" ----------------------------------------------
" syntax highlightを適用するために特定の拡張子とファイルタイプをマッピング
" ----------------------------------------------
autocmd BufNewFile,BufRead *.txt :set filetype=markdown

" ----------------------------------------------
" カラースキーム
" ----------------------------------------------
set t_Co=256
colorscheme xoria256
syntax on " syntax highlightを有効化

" ----------------------------------------------
" ステータスライン(with lightline)
" ----------------------------------------------
set laststatus=2
set showcmd " 入力中のコマンドをステータスに表示する
set ruler

" ----------------------------------------------
" タブ関連
" ----------------------------------------------
set expandtab     " indent, tabを半角スペースで入力する
set tabstop=2     " <TAB>を半角スペース2つにして表示
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set smartindent   " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=2  " smartindentで増減する幅
" タブの移動をmap
map L gt
map H gT

"----------------------------------------------------------
" コマンドモード
"----------------------------------------------------------
set wildmenu     " コマンドモードの補完
set history=1000 " 保存するコマンド履歴の数

"----------------------------------------------------------
" 文字列検索
"----------------------------------------------------------
set ignorecase  " 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase   " 検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan    " 検索時に最後まで行ったら最初に戻る
set hlsearch    " 検索結果のハイライト
" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

"----------------------------------------------------------
" コピペ時の自動インデントを無効
"----------------------------------------------------------
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>
endif

"----------------------------------------------------------
" その他細々とした設定
"----------------------------------------------------------
"set mouse=a             " マウス操作を有効にする
set visualbell t_vb=    " beep音を消す / set novisualbellはいらない気がする
set wildmode=list,full  " ファイルを開くときのコマンドラインモードのファイル補完
set number              " 行番号表示
set cursorline          " カーソルラインをハイライト
set showmatch           " 閉じ括弧が入力されたとき、対応する開き括弧に少しの間ジャンプ
set backspace=indent,eol,start " backspaceで削除できるものを強化 indent : 行頭の空白, eol : 改行 start : 挿入モード開始位置より手前の文字
set textwidth=0   " テキストの最大幅。長くなるとこの幅を超えないように空白の後で改行される。/ 0=無効
set nobackup      " Don't keep a backup file
set viminfo=      " dont' read/write a .viminfo file / set viminfo='500,<10000,s1000,\"500 " read/write a .viminfo file, don't store more than
set modelines=0   " modeline(ファイル毎のvimのオプション指定)を無効化
set title         " 端末のタイトルを変更する(タイトルバーとか)

" US配列の場合の入力しやすさ
nnoremap ; :

" map
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <silent> <expr> <C-e> (pumvisible() ? "\<C-e>" : "\<End>")
inoremap <C-d> <Del>

"buffer
nmap <Space>b :ls<CR>:buffer
nmap <Space>f :edit .<CR>
nmap <Space>v :vsplit<CR><C-w><C-w>:ls<CR>:buffer
nmap <Space>V :Vexplore!<CR><CR>

" バッファの移動をmap
map <C-n> :bn<Return>
map <C-p> :bp<Return>

" 辞書ファイルからの単語補間
set complete+=k

set grepprg=internal " alias grep='vimgrep'
" 検索レジストリに入ってる文字で現在のファイルを検索し、quickfix で開く
nnoremap <unique> g/ :exec ':vimgrep /' . getreg('/') . '/j %\|cwin'<CR>

" coc.nvim
" TABで補完候補を選択
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Enterで補完確定
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 定義ジャンプ
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" ドキュメント表示
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" 診断メッセージの移動
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
