""""""""""""""""""""""""""""""""""""""""
" .vimrc of Junegunn Choi
""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""
" Vundle block
set      nocompatible
filetype on
filetype off
let      $GIT_SSL_NO_VERIFY = 'true'
set      rtp+=~/.vim/bundle/vundle/
call     vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'L9'
Bundle 'a.vim'
Bundle 'grep.vim'
Bundle 'summerfruit256.vim'
Bundle 'junegunn/jellybeans.vim'
Bundle 'junegunn/Zenburn'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-fugitive'
Bundle 'gregsexton/gitv'
Bundle 'airblade/vim-gitgutter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'kana/vim-textobj-user'
Bundle 'vim-scripts/argtextobj.vim'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
Bundle 'junegunn/vim-scroll-position'
Bundle 'vim-scripts/VimClojure'
Bundle 'kien/rainbow_parentheses.vim'
" :CopyRTF
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    Bundle 'aniero/vim-copy-as-rtf'
  endif
endif
Bundle 'plasticboy/vim-markdown'
Bundle 'bronson/vim-visual-star-search'
Bundle 'mileszs/ack.vim'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"
Bundle 'ervandew/supertab'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'slim-template/vim-slim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'junegunn/vim-lesser-align'

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""

syntax on

set nu
set autoindent
set smartindent
set cindent
set nobackup
set lazyredraw
set laststatus=2
set showcmd
set visualbell
set backspace=indent,eol,start
set timeoutlen=500
set whichwrap=b,s
set shortmess=aI
set hlsearch " CTRL-L / CTRL-R W
set incsearch
set hidden
set ignorecase smartcase
set wildmenu
set tabstop=2
set shiftwidth=2
set expandtab smarttab
set scrolloff=5
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,euc-kr,latin1
set statusline=%<[%n]\ %F\ %m%r%y%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set pastetoggle=<Ins>
set pastetoggle=<F9> " For Mac
set modelines=2

" For MacVim
set noimd
set imi=1
set ims=-1

" ctags
set tags=./tags;/

" Annoying temporary files
set backupdir=/tmp
set directory=/tmp

" Shift-tab on GNU screen
set t_kB=[Z

" set complete=.,w,b,u,t
set complete-=i

" Color setting
" colo zenburn
set  t_Co=256
set  background=dark
colo jellybeans

" mouse
set ttymouse=xterm2
set mouse=a

" Make TOhtml use CSS and XHTML
let html_use_css=1
let use_xhtml=1

function! OverrideHighlight()
  " indent-guide
  hi IndentGuidesOdd       ctermbg=237
  hi IndentGuidesEven      ctermbg=237

  " vim-scroll-position
  hi SignColumn                  ctermbg=232
  hi ScrollPositionMarker        ctermfg=208 ctermbg=232
  hi ScrollPositionVisualBegin   ctermfg=196 ctermbg=232
  hi ScrollPositionVisualMiddle  ctermfg=196 ctermbg=232
  hi ScrollPositionVisualEnd     ctermfg=196 ctermbg=232
  hi ScrollPositionVisualOverlap ctermfg=196 ctermbg=232
  hi ScrollPositionChange        ctermfg=124 ctermbg=232
  hi ScrollPositionJump          ctermfg=131 ctermbg=232

  " vim-gitgutter
  hi GitGutterAdd          ctermfg=26  ctermbg=232
  hi GitGutterChange       ctermfg=107 ctermbg=232
  hi GitGutterDelete       ctermfg=124 ctermbg=232
  hi GitGutterChangeDelete ctermfg=202 ctermbg=232
endfunction

augroup vimrc
  autocmd!

  au VimEnter             *                   IndentGuidesEnable
  au VimEnter,Colorscheme *                   call OverrideHighlight()

  au BufRead              *                   setlocal foldmethod=manual
  au BufRead              *                   setlocal nofoldenable
  au BufWritePost         .vimrc              source % | call OverrideHighlight()

  au BufNewFile,BufRead   [Cc]apfile          set filetype=ruby
  au BufNewFile,BufRead   *.icc               set filetype=cpp
  au BufNewFile,BufRead   *.pde               set filetype=java
  au BufNewFile,BufRead   *.less              set filetype=less
  au BufNewFile,BufRead   *.god               set filetype=ruby
  au BufNewFile,BufRead   *.coffee-processing set filetype=coffee

  au Filetype ruby syn match rubyRocket "=>" | syn match rubyParens "[()]"
augroup END

if has("cscope")
  set csprg=/usr/local/bin/cscope
  set csto=0
  set cst
  set nocsverb
  " add any database in current directory
  let db = findfile('cscope.out', '.;')
  if db != ""
      exe("cs add ".db)
  " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
  endif
  set csverb

  "   's'   symbol: find all references to the token under cursor
  "   'g'   global: find global definition(s) of the token under cursor
  "   'c'   calls:  find all calls to the function name under cursor
  "   't'   text:   find all instances of the text under cursor
  "   'e'   egrep:  egrep search for the word under cursor
  "   'f'   file:   open the filename under cursor
  "   'i'   includes: find files that include the filename under cursor
  "   'd'   called: find functions that function under cursor calls
  nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

" Run script
function! RunThisScript()
  let head = getline(1)
  let pos = stridx(head, '#!')
  let file = expand('%')
  let absp = stridx(file, '/') == 0
  if !absp
    let file = './'.file
  end
  let xperm = executable(file)

  " She-bang found
  if pos != -1
    exe('!'.strpart(head, pos + 2).' '.file)
  " She-bang not found but executable
  elseif xperm
    exe('!'.file)
  elseif &filetype == 'ruby'
    exe('!/usr/bin/env ruby '.file)
  elseif &filetype == 'tex'
    exe('!latex '.file. '; [ $? -eq 0 ] && xdvi '. expand('%:r'))
  elseif &filetype == 'dot'
    let output = substitute(file, '.dot$', '.png', '')
    exe('!dot -Tpng '.file.' -o '.output.' && open '.output)
  end
endfunction
imap <F5> <esc>:call RunThisScript()<cr>
map  <F5> :call RunThisScript()<cr>

map ^[[6~ ^D
map ^[[5~ ^U

map ^[[B ^E
map ^[[A ^Y

map <C-F> <C-D>
map <C-B> <C-U>

" Under line
imap <F6> <esc>yyp:s/[^\t]/=/g<cr>:nohl<cr>a
map  <F6> yyp:s/[^\t]/=/g<cr>:nohl<cr>

" Save
imap <C-s> <esc>:w<cr>a
map  <C-s> :w<cr>

" Select-all (don't need confusing increment C-a)
map  <C-a> gg0vG$

" Quit
imap <C-Q> <esc>:q<cr>
map  <C-Q> :q<cr>

" Toggle line number display
map <F12> :set nonumber!<cr>

" NERD Tree
imap <F10> <esc>:NERDTreeToggle<cr>
map  <F10> :NERDTreeToggle<cr>

" Tagbar
imap <F11> <esc>:TagbarToggle<cr>
map  <F11> :TagbarToggle<cr>
let g:tagbar_sort = 0

" Window toggle
map <tab> <c-w>w
map <S-tab> <c-w>W

" Ctrl-P
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_max_height = 30
map <C-P><C-P> :CtrlPBuffer<cr>

" Escaping!
map! jk <esc>
vmap jk <esc>

" No delay in visual mode by jk
vmap v <down>
vmap V <down>

if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    " Clipboard
    vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>"))
    " Clipboard-RTF
    vmap <S-c> <esc>:colo summerfruit256<cr>gv:CopyRTF<cr>:colo jellybeans<cr>
  endif
endif

" NERD commenter
let mapleader = ","
vmap <C-_> <leader>c<space>gv
vmap <F7>  <leader>cc
vmap <F8>  <leader>cu

" Avoid JRuby RVM delay -- https://github.com/vim-ruby/vim-ruby/issues/33
if !empty(matchstr($MY_RUBY_HOME, 'jruby'))
  let g:ruby_path = join(split(glob($MY_RUBY_HOME.'/lib/ruby/*.*')."\n".glob($MY_RUBY_HOME.'/lib/rubysite_ruby/*'),"\n"),',')
endif

" Movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-^> <C-o><C-^>

" https://github.com/nelstrom/vim-textobj-rubyblock
runtime macros/matchit.vim
if has("autocmd")
  filetype indent plugin on
endif

" Bubble lines
noremap  <silent> <C-k> :execute "normal! ". (line('.') == 1 ? '' : (line('.') == line('$')) ? 'ddP' : 'ddkP')<cr>
noremap  <silent> <C-j> ddp
noremap  <silent> <C-h> <<
noremap  <silent> <C-l> >>
vnoremap <silent> <C-k> y:execute "normal! ". (line("'[") == 1 ? 'gv' : line("']") == line('$') ? "'[V']xP'[V']" : "'[V']xkP'[V']")<cr>
vnoremap <silent> <C-j> y'[V']xp'[V']
vnoremap <silent> <C-h> <gv
vnoremap <silent> <C-l> >gv

" Indentation
vnoremap < <gv
vnoremap > >gv

" Replace
vmap R "_dP

" Find and replace
map  fnr *:%s///gc<Left><Left><Left>
vmap fnr y:%s/<C-R>"//gc<Left><Left><Left>

" Vimclojure
augroup clojure
  autocmd!
  autocmd FileType clojure
    \ let maplocalleader             = " " |
    \ let vimclojure#ParenRainbow    = 1 |
    \ let vimclojure#WantNailgun     = 1 |
    \ let vimclojure#NailgunClient   = $HOME."/bin/ng" |
    \ let vimclojure#SearchThreshold = 30 |
    \ map <LocalLeader><LocalLeader> va)*``gv<LocalLeader>eb |
    \ set isk+="-?"
augroup END

" vim-scroll-position
" let g:scroll_position_jump = '-'
" let g:scroll_position_change = 'x'

" indent-guide
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" vim-slim
hi def link slimBegin NONE

" vim-lesser-align
vnoremap <silent> <Enter> :LesserAlign<cr>

