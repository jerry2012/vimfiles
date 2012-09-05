" Vundle block
let $GIT_SSL_NO_VERIFY = 'true'
filetype on  " MacOS Hack
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Required
Bundle 'gmarik/vundle'

" vim-scripts repos
Bundle 'L9'
Bundle 'a.vim'
Bundle 'cscope.vim'
Bundle 'grep.vim'
Bundle 'snipMate'
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
Bundle 'Raimondi/delimitMate'
Bundle 'vim-scripts/VimClojure'
" indent-object (vii)
Bundle 'michaeljsmith/vim-indent-object'
" :CopyRTF
Bundle 'aniero/vim-copy-as-rtf'
Bundle 'plasticboy/vim-markdown'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'bronson/vim-visual-star-search'
Bundle 'mileszs/ack.vim'
" Bundle 'Lokaltog/vim-powerline'

if has("ruby")
  Bundle 'wincent/Command-T'
else
  Bundle 'FuzzyFinder'
endif
" Bundle 'ervandew/supertab'
" Bundle 'spolu/dwm.vim'
" Bundle 'tpope/vim-unimpaired'

" use filetype plugins and indenting
filetype plugin indent on

set autoindent
set smartindent
set cindent
set nobackup
set nu

map ^[[6~ ^D
map ^[[5~ ^U

map ^[[B ^E
map ^[[A ^Y

" powerline-friendly remapping
map <C-F> <C-D>
map <C-B> <C-U>

" always show a status line
set laststatus=2

" show (partial) command in status line
set showcmd

" use visual bell instead of beeping
set visualbell

" don't redraw screen while exectuing macros
set lazyredraw

" allow backspace to erase over start of insert, autoindent, and eol
set backspace=indent,eol,start

" set timeout to 0.25 s. (jk)
set timeoutlen=250

" wrap cursor when using <bs> or <space>
set whichwrap=b,s

" avoid annoying "Hit ENTER to continue" prompts and intro-screen
set shortmess=aI

" highlight searches
set hlsearch

" incremental search
set incsearch

" syntax-hilighting, yes please
syntax on

" allow hiding a buffer without saving it first
set hidden

" make search queries case-insensitive, unless they contain upper-case letters
set ignorecase smartcase

" show possible matches above the command line when using tab completion
set wildmenu

" count a tab as 2 spaces
set tabstop=2

" use 2 tabs when indenting
set shiftwidth=2

" tab-smart
set expandtab smarttab

" restore visual selction after indenting
vnoremap < <gv
vnoremap > >gv

" display full path to file, filetype and buffer number in statusline
" (deprecated due to powerline... nah.. keep it)
set statusline=%<[%n]\ %F\ %m%r%y%=%-14.(%l,%c%V%)\ %P

" powerline (need font-patching)
" let g:Powerline_symbols = 'fancy'

" always show five lines above and below cursor
set scrolloff=5

" Make TOhtml use CSS and XHTML
let html_use_css=1
let use_xhtml=1

" Korean Language Setting
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,euc-kr,latin1

" ctags
set tags=./tags;/
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

" Under line
imap <F6> <esc>yyp:s/[^\t]/=/g<cr>:nohl<cr>a
map  <F6> yyp:s/[^\t]/=/g<cr>:nohl<cr>

" Save
imap <C-s> <esc>:w<cr>a
map  <C-s> :w<cr>

" Quit
imap <C-Q> <esc>:q<cr>
map  <C-Q> :q<cr>

" Toggle line number display
map <F12> :set nonumber!<cr>

" NERD Tree
"imap <F11> <esc>:exe "cd " . fnamemodify(expand('%'), ":p:h")<cr>:NERDTree<cr>
"map  <F11> :exe "cd " . fnamemodify(expand('%'), ":p:h")<cr>:NERDTree<cr>
imap <F11> <esc>:NERDTree<cr>
map  <F11> :NERDTree<cr>

set pastetoggle=<Ins>
set pastetoggle=<F9> " For Mac

map      <tab>   <C-W><C-W>
if has("ruby")
  map  <S-tab> :CommandTBuffer<cr>
  map  <F7>    ,t
  imap <F7>    <esc>,t
else
  map  <S-tab> :FufBuffer<cr>
  imap <F7>    <esc>:FufFile **/<cr>
  map  <F7>    :FufFile **/<cr>
end

" Escaping!
map! jk <esc>
vmap jk <esc>

" No delay in visual mode by jk
" vmap <expr> v mode() == 'V' ? '<down>' : ''
vmap v <down>
vmap V <down>

" For MacVim
set noimd
set imi=1
set ims=-1

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

" Annoying temporary files
set backupdir=/tmp
set directory=/tmp

" Grep in MacOS
let Grep_Xargs_Options = '-0'
let Grep_Skip_Files = '*.bak *~ *.swp *.log'

" Movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-^> <C-o><C-^>

" Shift-tab on GNU screen
set t_kB=[Z

" https://github.com/nelstrom/vim-textobj-rubyblock
runtime macros/matchit.vim
set nocompatible
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
vmap <C-T>=  :Tab /=<CR>
vmap <C-T>== :Tab /[- +*/]\{,1}=<CR>
vmap <C-T>=> :Tab /=><CR>

" Sloppy, but does the work (Assuming # comment)
vmap <C-T><space>           :s/^\([^#]\{-\}[^# \t]\) /\1:__TBLR__:/<CR>gv:Tab /:__TBLR__:<CR>gv:s/:__TBLR__: //<CR>:nohl<CR>
vmap <C-T><C-T><space>      :s/^\([^#]\{-\}[^# \t] \+[^ ]\+ \+\)/\1:__TBLR__:/<CR>gv:Tab /:__TBLR__:<CR>gv:s/:__TBLR__: //<CR>:nohl<CR>
vmap <C-T><C-T><C-T><space> :s/^\([^#]\{-\}[^# \t] \+[^ ]\+ \+[^ ]\+ \+\)/\1:__TBLR__:/<CR>gv:Tab /:__TBLR__:<CR>gv:s/:__TBLR__: //<CR>:nohl<CR>
let g:tabular_default_format = "l1-1"

" Replace
vmap R "_dP

let vimclojure#ParenRainbow = 1

" set complete=.,w,b,u,t
set complete-=i

augroup vimrc
  autocmd!

  au BufWritePost .vimrc source %
  au BufReadPre * setlocal foldmethod=syntax
  au BufReadPre * setlocal nofoldenable

  au BufNewFile,BufRead capfile	setf ruby
  au BufNewFile,BufRead Capfile	setf ruby
  au BufRead,BufNewFile *.icc  set filetype=cpp
  au BufRead,BufNewFile *.pde  set filetype=java
  au BufNewFile,BufRead *.less set filetype=less
  au BufNewFile,BufRead *.god  set filetype=ruby
  au BufNewFile,BufRead *.coffee-processing	setf coffee
augroup END

" Color setting
set  t_Co=256
set  background=dark
colo zenburn

" mouse
set ttymouse=xterm2
set mouse=a

" rnu
" if v:version >= 703
"   set rnu
"   au BufEnter * :set rnu
"   au BufLeave * :set nu
"   au WinEnter * :set rnu
"   au WinLeave * :set nu
"   au InsertEnter * :set nu
"   au InsertLeave * :set rnu
"   au FocusLost * :set nu
"   au FocusGained * :set rnu
" endif
