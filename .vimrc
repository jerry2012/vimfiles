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
silent!  call vundle#rc()
if       exists(':Bundle')
Bundle   'gmarik/vundle'

" Edit
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-abolish'
Bundle 'tomtom/tcomment_vim'
Bundle 'bronson/vim-visual-star-search'
Bundle 'ervandew/supertab'
Bundle 'junegunn/vim-easy-align'
Bundle 'tpope/vim-tbone'
Bundle 'kshenoy/vim-signature'
if has("unix") && system("uname") == "Darwin\n"
  Bundle 'zerowidth/vim-copy-as-rtf'
endif

" Browsing
Bundle 'a.vim'
Bundle 'grep.vim'
Bundle 'mileszs/ack.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'junegunn/vim-github-dashboard'

" Git
Bundle 'tpope/vim-fugitive'
Bundle 'gregsexton/gitv'
Bundle 'airblade/vim-gitgutter'

" Snippets
Bundle 'honza/vim-snippets'
Bundle   'garbas/vim-snipmate'
Bundle     'tomtom/tlib_vim'
Bundle     'MarcWeber/vim-addon-mw-utils'

" Text object
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle   'kana/vim-textobj-user'
Bundle 'vim-scripts/argtextobj.vim'
Bundle 'michaeljsmith/vim-indent-object'

" Lang
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'plasticboy/vim-markdown'
Bundle 'slim-template/vim-slim'
Bundle 'jnwhiteh/vim-golang'
Bundle 'junegunn/vim-redis'
Bundle 'vim-scripts/VimClojure'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'ap/vim-css-color'

" Visual
Bundle 'Yggdroot/indentLine'
Bundle 'junegunn/vim-scroll-position'

" Colors
Bundle 'junegunn/seoul256.vim'
Bundle 'junegunn/jellybeans.vim'
Bundle 'junegunn/Zenburn'
Bundle 'summerfruit256.vim'
Bundle 'beauty256'

endif | filetype plugin indent on
""""""""""""""""""""""""""""""""""""""""
" End of Vundle block
""""""""""""""""""""""""""""""""""""""""

let mapleader = ","
let maplocalleader = " "

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
set statusline=%<[%n]\ %F\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}%=%-14.(%l,%c%V%)\ %P
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
silent! colo seoul256

" mouse
set ttymouse=xterm2
set mouse=a

" Googling
set keywordprg=open\ http://www.google.com/search?q=\

" 80 chars/line
set textwidth=80
set colorcolumn=+1

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
function! RunThisScript(output)
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
    let svg = substitute(file, '.dot$', '.svg', '')
    let png = substitute(file, '.dot$', '.png', '')
    execute '!dot -Tsvg '.file.' -o '.svg.' && '
          \ 'mogrify -density 300 -format png '.svg.' && open '.png.redir
  else
    return
  end

  " Scratch buffer
  if !a:output
    return
  endif
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
inoremap <silent> <F5> <esc>:call RunThisScript(0)<cr>
noremap  <silent> <F5> :call RunThisScript(0)<cr>
inoremap <silent> <F6> <esc>:call RunThisScript(1)<cr>
noremap  <silent> <F6> :call RunThisScript(1)<cr>

noremap ^[[6~ ^D
noremap ^[[5~ ^U

noremap ^[[B ^E
noremap ^[[A ^Y

noremap <C-F> <C-D>
noremap <C-B> <C-U>

" Save
inoremap <C-s> <esc>:w<cr>a
noremap  <C-s> :w<cr>

" Select-all (don't need confusing increment C-a)
noremap  <C-a> gg0vG$

" Quit
inoremap <C-Q> <esc>:q<cr>
noremap  <C-Q> :q<cr>
vnoremap <C-Q> <esc><cr>

" Toggle line number display
noremap <F12> :set nonumber!<cr>

" NERD Tree
inoremap <F10> <esc>:NERDTreeToggle<cr>
noremap  <F10> :NERDTreeToggle<cr>

" Tagbar
inoremap <F11> <esc>:TagbarToggle<cr>
noremap  <F11> :TagbarToggle<cr>
let g:tagbar_sort = 0

" Jump list
noremap g[      <C-o>
noremap g]      <C-i>

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

" vim-copy-as-rtf
if has("unix")
  if system("uname") == "Darwin\n"
    " Clipboard
    vnoremap <C-c> y:call system("pbcopy", getreg("\""))<CR>"))
    " Clipboard-RTF
    vnoremap <S-c> <esc>:colo summerfruit256<cr>gv:CopyRTF<cr>:colo seoul256<cr>
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

" Bubble lines
noremap  <silent> <C-k> :execute ":move ".max([0,         line('.') - 2])<cr>
noremap  <silent> <C-j> :execute ":move ".min([line('$'), line('.') + 1])<cr>
noremap  <silent> <C-h> <<
noremap  <silent> <C-l> >>
vnoremap <silent> <C-k> :<C-U>execute "normal! gv:move ".max([0,         line("'<") - 2])."\n"<cr>gv
vnoremap <silent> <C-j> :<C-U>execute "normal! gv:move ".min([line('$'), line("'>") + 1])."\n"<cr>gv
vnoremap <silent> <C-h> <gv
vnoremap <silent> <C-l> >gv

" Indentation
vnoremap < <gv
vnoremap > >gv

" Replace
function! Replace()
  if visualmode() ==# 'V'
    if line("'>") == line('$')
      normal! gv"_dp
    else
      normal! gv"_dP
    endif
  else
    if col("'>") == col('$') - 1
      normal! gv"_dp
    else
      normal! gv"_dP
    endif
  endif
endfunction
" vnoremap R "_dP
vnoremap R :<C-U>call Replace()<cr>

" Find and replace
noremap  fnr *:%s###gc<Left><Left><Left>
vnoremap fnr y:%s#<C-R>"##gc<Left><Left><Left>

" Circular windows navigation
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" Clear search highlights
noremap <silent><localleader>/ :nohl<CR>

" Make Y behave like other capitals
map Y y$

" Tmux navigation
" - http://www.codeography.com/2013/06/19/navigating-vim-and-tmux-splits.html
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir, prev)
    execute "wincmd " . a:wincmd
    if a:prev == winnr()
      " The sleep and & gives time to get back to vim so tmux's focus tracking
      " can kick in and send us our ^[[O
      execute "silent !sh -c 'sleep 0.01; tmux select-pane -" . a:tmuxdir . "' &"
      redraw!
    endif
  endfunction
  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te
  nnoremap <silent> \h     :call TmuxOrSplitSwitch('h', 'L', winnr())<cr>
  nnoremap <silent> \j     :call TmuxOrSplitSwitch('j', 'D', winnr())<cr>
  nnoremap <silent> \k     :call TmuxOrSplitSwitch('k', 'U', winnr())<cr>
  nnoremap <silent> \l     :call TmuxOrSplitSwitch('l', 'R', winnr())<cr>
  nnoremap <silent> \<tab> :call TmuxOrSplitSwitch('w', 't :.+', 1)<cr>
endif

" vim-textobj-rubyblock
runtime macros/matchit.vim

" vim-scroll-position
" let g:scroll_position_jump = '-'
" let g:scroll_position_change = 'x'
" let g:scroll_position_auto_enable = 0

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" vim-easy-align
let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ '/': { 'pattern': '//\+\|/\*\|\*/' },
\ '#': { 'pattern': '#\+' },
\ ']': {
\     'margin_left':   '',
\     'pattern':       '[\[\]]',
\     'margin_right':  '',
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       '[()]',
\     'margin_left':   '',
\     'margin_right':  '',
\     'stick_to_left': 0
\   }
\ }
vnoremap <silent> <Enter> :EasyAlign<cr>

" vim-redis
" let g:vim_redis_host = 'localhost'
" let g:vim_redis_port = '6379'
" let g:vim_redis_auth = 'xxx'
let g:vim_redis_paste_command = 1
let g:vim_redis_paste_command_prefix = '> '
noremap  <silent> <leader>re :RedisExecute<cr>
vnoremap <silent> <leader>re :RedisExecuteVisual<cr>gv
noremap  <silent> <leader>rw :RedisWipe<cr>
noremap  <silent> <leader>rq :RedisQuit<cr>

" vim-tbone
function! TmuxSend() range
  echon "To which pane? (t = .1) "
  let char = getchar()
  if char == 116
    let target = '.1'
  else
    let target = nr2char(char)
  endif
  silent call tbone#write_command(0, a:firstline, a:lastline, 1, target)
endfunction
noremap  <silent> <leader>t :call TmuxSend()<cr>
vnoremap <silent> <leader>t :call TmuxSend()<cr>

function! RotateColors()
  if !exists("s:colors_list")
    let s:colors_list =
    \ sort(map(
    \   filter(split(globpath(&rtp, "colors/*.vim"), "\n"), 'v:val !~ "^/usr/"'),
    \   "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"))
  endif
  if !exists("s:colors_index")
    let s:colors_index = index(s:colors_list, g:colors_name)
  endif
  let s:colors_index = (s:colors_index + 1) % len(s:colors_list)
  let name = s:colors_list[s:colors_index]
  execute "colorscheme " . name
  redraw
  echo name
endfunction
noremap <F8> :call RotateColors()<cr>

function! Shuffle()
ruby << EOF
  buf = VIM::Buffer.current
  firstnum = VIM::evaluate('a:firstline').to_i
  lastnum = VIM::evaluate('a:lastline').to_i
  (firstnum..lastnum).map { |l| buf[l] }.shuffle.each_with_index do |line, i|
    buf[firstnum + i] = line
  end
EOF
endfunction
command! -range Shuffle <line1>,<line2>call Shuffle()

function! GFM()
  let syntaxes = {
  \ 'ruby':   '~/.vim/bundle/vim-ruby/syntax/ruby.vim',
  \ 'yaml':   '~/.vim/syntax/yaml.vim',
  \ 'vim':    'syntax/vim.vim',
  \ 'sh':     'syntax/sh.vim',
  \ 'python': 'syntax/python.vim',
  \ 'java':   'syntax/java.vim',
  \ 'c':      'syntax/c.vim'
  \ }

  for [lang, syn] in items(syntaxes)
    unlet b:current_syntax
    silent! exec printf("syntax include @%s %s", lang, syn)
    exec printf("syntax region %sSnip matchgroup=Snip start='```%s' end='```' contains=@%s",
                \ lang, lang, lang)
  endfor
  if g:colors_name =~ 'light'
    highlight def Snip ctermfg=231
  else
    highlight def Snip ctermfg=232
  endif
  let b:current_syntax='mkd'
endfunction

augroup vimrc
  autocmd!

  au BufRead              *                   setlocal foldmethod=manual
  au BufRead              *                   setlocal nofoldenable
  au BufWritePost         .vimrc              source %

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
  au FileType    mkd  :call GFM()
  au ColorScheme *.md :call GFM()

  " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
  au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
  au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/
augroup END
command! Chomp silent! normal! :%s/\s\+$//<cr>

" vim-github-dashboard
let g:github_dashboard = { 'username': 'junegunn' }

" For screencasting with Keycastr
" map <tab> <nop>
" imap <tab> <nop>
" vmap <tab> <nop>

set list listchars=tab:\|\ ,
