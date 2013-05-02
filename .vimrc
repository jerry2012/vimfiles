""""""""""""""""""""""""""""""""""""""""
" .vimrc of Junegunn Choi
""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""
" Vundle block
""""""""""""""""""""""""""""""""""""""""
set      nocompatible
filetype on
filetype off
let      $GIT_SSL_NO_VERIFY = 'true'
set      rtp+=~/.vim/bundle/vundle/
call     vundle#rc()
let      mapleader = ","
let      maplocalleader = " "

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
Bundle 'tomtom/tcomment_vim'
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
Bundle 'plasticboy/vim-markdown'
Bundle 'bronson/vim-visual-star-search'
Bundle 'mileszs/ack.vim'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"
Bundle 'ervandew/supertab'
Bundle 'Yggdroot/indentLine'
Bundle 'slim-template/vim-slim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'junegunn/vim-easy-align'
Bundle 'jnwhiteh/vim-golang'
Bundle 'CCTree'
" :CopyRTF
if has("unix") && system("uname") == "Darwin\n"
  Bundle 'zerowidth/vim-copy-as-rtf'
endif

filetype plugin indent on
""""""""""""""""""""""""""""""""""""""""
" End of Vundle block
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
let g:html_use_css=1
let g:use_xhtml=1

if has("cscope")
  set csprg=/usr/local/bin/cscope
  set csto=0
  set cst
  set nocsverb
  " add any database in current directory
  let db = findfile('cscope.out', '.;')
  if db != ""
      execute("cs add ".db)
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
  noremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  noremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  noremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  noremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  noremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  noremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  noremap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  noremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

" Run script
function! RunThisScript()
  let head = getline(1)
  let pos  = stridx(head, '#!')
  let file = expand('%')
  let absp = stridx(file, '/') == 0
  if !absp
    let file = './'.file
  end

  let ofile = "/tmp/vim-exec.txt"
  let redir = " 2>&1 | tee ".ofile
  " She-bang found
  if pos != -1
    execute '!'.strpart(head, pos + 2).' '.file.redir
  " She-bang not found but executable
  elseif executable(file)
    execute '!'.file.redir
  elseif &filetype == 'ruby'
    execute '!/usr/bin/env ruby '.file.redir
  elseif &filetype == 'tex'
    execute '!latex '.file. '; [ $? -eq 0 ] && xdvi '. expand('%:r').redir
  elseif &filetype == 'dot'
    let output = substitute(file, '.dot$', '.png', '')
    execute '!dot -Tpng '.file.' -o '.output.' && open '.output.redir
  else
    return
  end

  " Scratch buffer
  let sr = &splitright
  set      splitright
  silent!  bdelete [vim-exec-output]
  silent!  100vnew
  silent!  file [vim-exec-output]
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  set      nowrap
  execute  "silent! read ".ofile
  normal!  gg"_dd
  execute  "normal! \<C-W>p"
  if !sr
    set nosplitright
  endif
endfunction
inoremap <silent> <F5> <esc>:call RunThisScript()<cr>
noremap  <silent> <F5> :call RunThisScript()<cr>

noremap ^[[6~ ^D
noremap ^[[5~ ^U

noremap ^[[B ^E
noremap ^[[A ^Y

noremap <C-F> <C-D>
noremap <C-B> <C-U>

" Under line
inoremap <F6> <esc>yyp:s/[^\t]/=/g<cr>:nohl<cr>a
noremap  <F6> yyp:s/[^\t]/=/g<cr>:nohl<cr>

" Save
inoremap <C-s> <esc>:w<cr>a
noremap  <C-s> :w<cr>

" Select-all (don't need confusing increment C-a)
noremap  <C-a> gg0vG$

" Quit
inoremap <C-Q> <esc>:q<cr>
noremap  <C-Q> :q<cr>

" Toggle line number display
noremap <F12> :set nonumber!<cr>

" NERD Tree
inoremap <F10> <esc>:NERDTreeToggle<cr>
noremap  <F10> :NERDTreeToggle<cr>

" Tagbar
inoremap <F11> <esc>:TagbarToggle<cr>
noremap  <F11> :TagbarToggle<cr>
let g:tagbar_sort = 0

" Window toggle
noremap <tab> <c-w>w
noremap <S-tab> <c-w>W

" Ctrl-P
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_max_height = 30
noremap <C-P><C-P> :CtrlPBuffer<cr>

" Escaping!
noremap! jk <C-c>
vnoremap jk <C-c>

" No delay in visual mode by jk
vnoremap v <down>
vnoremap V <down>

if has("unix")
  if system("uname") == "Darwin\n"
    " Clipboard
    vnoremap <C-c> y:call system("pbcopy", getreg("\""))<CR>"))
    " Clipboard-RTF
    vnoremap <S-c> <esc>:colo summerfruit256<cr>gv:CopyRTF<cr>:colo jellybeans<cr>
  endif
endif

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
vnoremap R "_dP

" Find and replace
noremap  fnr *:%s///gc<Left><Left><Left>
vnoremap fnr y:%s/<C-R>"//gc<Left><Left><Left>

" vim-scroll-position
" let g:scroll_position_jump = '-'
" let g:scroll_position_change = 'x'
" let g:scroll_position_auto_enable = 0

" indentLine
let g:indentLine_color_term = 238

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" vim-easy-align
let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' }
\ }
vnoremap <silent> <Enter> :EasyAlign<cr>

function! OverrideHighlight()
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
  hi GitGutterAdd                ctermfg=26  ctermbg=232
  hi GitGutterChange             ctermfg=107 ctermbg=232
  hi GitGutterDelete             ctermfg=124 ctermbg=232
  hi GitGutterChangeDelete       ctermfg=202 ctermbg=232
endfunction

augroup vimrc
  autocmd!

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

  au Filetype slim hi def link slimBegin NONE

  au FileType clojure
    \ let vimclojure#ParenRainbow    = 1                     |
    \ let vimclojure#WantNailgun     = 1                     |
    \ let vimclojure#NailgunClient   = $HOME."/bin/ng"       |
    \ let vimclojure#SearchThreshold = 30                    |
    \ map <LocalLeader><LocalLeader> va)*``gv<LocalLeader>eb |
    \ set isk+="-?"
augroup END

