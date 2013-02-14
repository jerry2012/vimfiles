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
Bundle   'gmarik/vundle'

Bundle 'L9'
Bundle 'a.vim'
Bundle 'grep.vim'
Bundle 'vcscommand.vim'
Bundle 'summerfruit256.vim'
Bundle 'junegunn/jellybeans.vim'
Bundle 'junegunn/Zenburn'
Bundle 'rosstimson/scala-vim-support'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'gregsexton/gitv'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'junegunn/tabular'
" Bundle 'Raimondi/delimitMate'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/Gundo'
Bundle 'majutsushi/tagbar'
Bundle 'junegunn/vim-scroll-position'

" VimClojure
Bundle 'vim-scripts/VimClojure'

" indent-object (vii)
Bundle 'michaeljsmith/vim-indent-object'
" :CopyRTF
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    Bundle 'aniero/vim-copy-as-rtf'
  endif
endif
Bundle 'plasticboy/vim-markdown'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'bronson/vim-visual-star-search'
Bundle 'mileszs/ack.vim'

" SnipMate
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/snipmate-snippets"
Bundle "garbas/vim-snipmate"

" Bundle 'altercation/vim-colors-solarized'
" Bundle 'Lokaltog/vim-powerline'
" Bundle 'ervandew/supertab'
" Bundle 'spolu/dwm.vim'
" Bundle 'tpope/vim-unimpaired'

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""

syntax on

set autoindent
set smartindent
set cindent
set nobackup
set nu
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
set statusline=%<[%n]\ %F\ %m%r%y%=%-14.(%l,%c%V%)\ %P
set pastetoggle=<Ins>
set pastetoggle=<F9> " For Mac

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
set  t_Co=256
set  background=dark
" colo zenburn
colo jellybeans

" mouse
set ttymouse=xterm2
set mouse=a

" Make TOhtml use CSS and XHTML
let html_use_css=1
let use_xhtml=1

" Grep in MacOS
let Grep_Xargs_Options = '-0'
let Grep_Skip_Files = '*.bak *~ *.swp *.log'

augroup vimrc
  autocmd!

  au BufWritePost       .vimrc              source %
  au BufRead            *                   setlocal foldmethod=syntax
  au BufRead            *                   setlocal nofoldenable

  au BufNewFile,BufRead capfile             setf ruby
  au BufNewFile,BufRead Capfile             setf ruby
  au BufRead,BufNewFile *.icc               set filetype=cpp
  au BufRead,BufNewFile *.pde               set filetype=java
  au BufNewFile,BufRead *.less              set filetype=less
  au BufNewFile,BufRead *.god               set filetype=ruby
  au BufNewFile,BufRead *.coffee-processing setf coffee
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

  """"""""""""" My cscope/vim key mappings
  "
  " The following maps all invoke one of the following cscope search types:
  "
  "   's'   symbol: find all references to the token under cursor
  "   'g'   global: find global definition(s) of the token under cursor
  "   'c'   calls:  find all calls to the function name under cursor
  "   't'   text:   find all instances of the text under cursor
  "   'e'   egrep:  egrep search for the word under cursor
  "   'f'   file:   open the filename under cursor
  "   'i'   includes: find files that include the filename under cursor
  "   'd'   called: find functions that function under cursor calls
  "
  " Below are three sets of the maps: one set that just jumps to your
  " search result, one that splits the existing vim window horizontally and
  " diplays your search result in the new window, and one that does the same
  " thing, but does a vertical split instead (vim 6 only).
  "
  " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
  " unlikely that you need their default mappings (CTRL-\'s default use is
  " as part of CTRL-\ CTRL-N typemap, which basically just does the same
  " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
  " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
  " of these maps to use other keys.  One likely candidate is 'CTRL-_'
  " (which also maps to CTRL-/, which is easier to type).  By default it is
  " used to switch between Hebrew and English keyboard mode.
  "
  " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
  " that searches over '#include <time.h>" return only references to
  " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
  " files that contain 'time.h' as part of their name).


  " To do the first type of search, hit 'CTRL-\', followed by one of the
  " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
  " search will be displayed in the current window.  You can use CTRL-T to
  " go back to where you were before the search.  
  "

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
    exe('!dot -Tpng '.file.' -o '.file.'.png && open '.file.'.png')
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

vnoremap < <gv
vnoremap > >gv

" Under line
imap <F6> <esc>yyp:s/[^\t]/=/g<cr>:nohl<cr>a
map  <F6> yyp:s/[^\t]/=/g<cr>:nohl<cr>

" Gundo
imap <F7> <esc>:GundoShow<cr>
map <F7> :GundoShow<cr>

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
"imap <F11> <esc>:exe "cd " . fnamemodify(expand('%'), ":p:h")<cr>:NERDTree<cr>
"map  <F11> :exe "cd " . fnamemodify(expand('%'), ":p:h")<cr>:NERDTree<cr>
imap <F10> <esc>:NERDTreeToggle<cr>
map  <F10> :NERDTreeToggle<cr>
" autocmd vimenter * if !argc() | NERDTree | endif

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
    vmap <S-c> <esc>:colo summerfruit256<cr>gv:CopyRTF<cr>:colo zenburn<cr>
  endif
endif

" Doesn't seem to work though
map! ㅇㄱ <esc>
vmap ㅇㄱ <esc>

" NERD comment
let mapleader = ","
vmap <F7> <leader>cc
vmap <F8> <leader>cu

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
nmap <C-k> :call feedkeys( line('.')==1 ? '' : 'ddkP' )<CR>
nmap <C-j> ddp
nmap <C-h> <<
nmap <C-l> >>
vmap <C-k> xkP`[V`]
vmap <C-j> xp`[V`]

" Indentation
vmap <C-h> <
vmap <C-l> >

" Tabular.vim
vmap <C-T>:  :Tab /:<CR>
vmap <C-T>:: :Tab /:\zs<CR>
vmap <C-T>,  :Tab /,\zs<CR>
vmap <C-T>=  :Tab /=<CR>
vmap <C-T>== :Tab /[- +*/]\{,1}=<CR>
vmap <C-T>=> :Tab /=><CR>

" Sloppy, but does the work (Assuming # comment)
vmap <C-T><space>           :s/^\([^#]\{-\}[^# \t]\) /\1:__TBLR__:/<CR>gv:Tab /:__TBLR__:<CR>gv:s/:__TBLR__: //<CR>:nohl<CR>
vmap <C-T><C-T><space>      :s/^\([^#]\{-\}[^# \t] \+[^ ]\+ \+\)/\1:__TBLR__:/<CR>gv:Tab /:__TBLR__:<CR>gv:s/:__TBLR__: //<CR>:nohl<CR>
vmap <C-T><C-T><C-T><space> :s/^\([^#]\{-\}[^# \t] \+[^ ]\+ \+[^ ]\+ \+\)/\1:__TBLR__:/<CR>gv:Tab /:__TBLR__:<CR>gv:s/:__TBLR__: //<CR>:nohl<CR>
vmap <C-T><C-T><C-T><C-T><space> :s/^\([^#]\{-\}[^# \t] \+[^ ]\+ \+[^ ]\+ \+[^ ]\+ \+\)/\1:__TBLR__:/<CR>gv:Tab /:__TBLR__:<CR>gv:s/:__TBLR__: //<CR>:nohl<CR>
let g:tabular_default_format = "l1-1"

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
highlight ScrollPositionMarker ctermfg=208 ctermbg=232
highlight SignColumn ctermbg=232
