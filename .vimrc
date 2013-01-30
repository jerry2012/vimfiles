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
Bundle 'cscope.vim'
Bundle 'grep.vim'
Bundle 'vcscommand.vim'
Bundle 'summerfruit256.vim'
Bundle 'jellybeans.vim'
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
colo zenburn

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

" cscope
silent! cs add ./cscope.out
silent! cs add ../cscope.out
silent! cs add ../../cscope.out
silent! cs add ../../../cscope.out
silent! cs add ../../../../cscope.out
silent! cs add ../../../../../cscope.out
if $CSCOPE_DB != ""
	silent! cs add $CSCOPE_DB
endif
function! Csbuild()
  exe("!csbuild -n")
  silent! cs add ./cscope.out
endfunction
com! Csbuild call Csbuild()

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
let maplocalleader             = " "
let vimclojure#ParenRainbow    = 1
let vimclojure#WantNailgun     = 1
let vimclojure#NailgunClient   = $HOME."/bin/ng"
let vimclojure#SearchThreshold = 30
map <LocalLeader><LocalLeader> va)*``gv<LocalLeader>eb
set isk+="-?"
