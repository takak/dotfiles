scriptencoding utf-8  " vimで使用するencodeの設定
set nocompatible      " vi互換無効化

" vundleの設定
filetype off 
set rtp+=~/.vim/vundle.git/ " github管理仕様 set rtp+=~/.vim/vundle.git/
call vundle#rc()

" vundleで使うプラグイン
Bundle 'haml.zip'
Bundle 'tpope/vim-rails'
Bundle 'evidens/vim-twig'
Bundle 'vim-coffee-script'

Bundle 'xoria256.vim'
Bundle 'neocomplcache'

Bundle 'quickrun'

Bundle 'unite.vim'
Bundle 'h1mesuke/unite-outline'

Bundle 'AtsushiM/search-parent.vim'
Bundle 'AtsushiM/sass-compile.vim'

" 256色表示とスキーマの設定
set t_Co=256
colorscheme xoria256

" statusline
set laststatus=2
set statusline=%F%m%r%h%w\%=[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\[LOW=%l/%L]

" syntax highlightを有効化
syntax on

" 全角スペース滅ぶべし
highlight ZenkakuSpace cterm=underline ctermbg=white ctermfg=blue
match ZenkakuSpace /　/

" 細々とした設定
set visualbell t_vb=    " beep音を消す / set novisualbellはいらない気がする
set wildmode=list,full  " ファイルを開くときのコマンドラインモードのファイル補完
set number              " 行番号表示
set showcmd             " 入力中のコマンドをステータスに表示する
set showmatch           " 閉じ括弧が入力されたとき、対応する開き括弧に少しの間ジャンプ
set backspace=indent,eol,start " backspaceで削除できるものを強化 indent : 行頭の空白, eol : 改行 start : 挿入モード開始位置より手前の文字
set textwidth=0   " テキストの最大幅。長くなるとこの幅を超えないように空白の後で改行される。/ 0=無効
set nobackup      " Don't keep a backup file
set viminfo=      " dont' read/write a .viminfo file / set viminfo='500,<10000,s1000,\"500 " read/write a .viminfo file, don't store more than
set history=1000  " keep command line history

" US配列ェ・・・
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

" タブの移動をmap
map L gt
map H gT

" バッファの移動をmap
map <C-n> :bn<Return>
map <C-p> :bp<Return>

" タブ関連
set expandtab     " indent, tabを半角スペースで入力する
set tabstop=2     " <TAB>を半角スペース2つにして表示
set softtabstop=2 " <TAB>キーを押した時に挿入される半角スペース量
set shiftwidth=2  " vimが挿入するインデント等の画面上のインデント幅
set modelines=0   " modeline(ファイル毎のvimのオプション指定)を無効化
set title         " 端末のタイトルを変更する(タイトルバーとか)
set smartindent   " 新しい行を作ったときに高度な自動インデントを行う(って書いてる)

" 検索関連
set ignorecase  " 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase   " 検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan    " 検索時に最後まで行ったら最初に戻る
set hlsearch    " 検索で色をつける

" gh で highlight を消す
nnoremap <silent> gh :let @/=''<CR>

" svn/git での文字エンコーディング設定
autocmd FileType svn :set fileencoding=utf-8
autocmd FileType git :set fileencoding=utf-8

" markdownのsyntax highlightを適用するためにtxtをmarkdown形式で読み込む
autocmd BufNewFile,BufRead *.txt :set filetype=markdown

" 辞書ファイルからの単語補間
set complete+=k

set grepprg=internal " alias grep='vimgrep'
" 検索レジストリに入ってる文字で現在のファイルを検索し、quickfix で開く
nnoremap <unique> g/ :exec ':vimgrep /' . getreg('/') . '/j %\|cwin'<CR>

" unite --------------------------------------------------------------
nnoremap <silent> ,uf :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent> ,uc :<C-u>UniteWithBufferDir -vertical -winwidth=30 -buffer-name=files file<CR>
"" 垂直分割でアウトラインを表示、選択後もbufferを閉じない
nnoremap <silent> <C-u><C-o> :<C-u>Unite -winheight=10 -direction=aboveleft -no-quit outline<CR>
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" unite --------------------------------------------------------------

" NeoCompleCache.vim
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_auto_select = 1
" Use smartcase.
let g:neocomplcache_enable_ignore_case = 0
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_enable_quick_match = 1
let g:neocomplcache_enable_wildcard = 1
let g:neocomplcache_snippets_dir = $HOME.'/.vim/snippets'

nnoremap <silent> ent :NeoComplCacheCachingTags<CR>

" <CR>: close popup and save indent.
" inoremap <expr><CR> neocomplcache#smart_close_popup() . (&indentexpr != '' " ? "\<C-f>\<CR>X\<BS>":"\<CR>")
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()

augroup UjihisaRSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END

" auto scss -> css
let g:sass_compile_auto = 1
let g:sass_compile_cdloop = 0
" let g:sass_compile_cssdir = ['rocobee']
" let g:sass_compile_cssdir = ['pictcake-faq']
let g:sass_compile_cssdir = ['cake_tokyo']
let g:sass_compile_file = ['scss', 'sass']
let g:sass_compile_beforecmd = ''
let g:sass_compile_aftercmd = ''
"}}}
