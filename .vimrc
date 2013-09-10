""""""""""""""""""""""""""""""""""""""""
" .vimrc of Junegunn Choi
""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""
" vim-plug block
""""""""""""""""""""""""""""""""""""""""
let $GIT_SSL_NO_VERIFY = 'true'
silent! call plug#init()
if exists(':Plug')

" Edit
Plug 'gmarik/vundle'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
" Plug 'tpope/vim-abolish'
Plug 'tomtom/tcomment_vim'
Plug 'ervandew/supertab'
Plug 'junegunn/vim-easy-align'
Plug 'kshenoy/vim-signature'
if has("unix") && system("uname") == "Darwin\n"
  Plug 'zerowidth/vim-copy-as-rtf'
endif

" Tmux
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-dispatch'

" Browsing
Plug 'a.vim'
" Plug 'grep.vim'
Plug 'mileszs/ack.vim'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'junegunn/vim-github-dashboard'

" Git
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'airblade/vim-gitgutter'

" Snippets
" Plug 'honza/vim-snippets'
" Plug   'garbas/vim-snipmate'
" Plug     'tomtom/tlib_vim'
" Plug     'MarcWeber/vim-addon-mw-utils'

" Text object
" Plug 'nelstrom/vim-textobj-rubyblock'
" Plug   'kana/vim-textobj-user'
" Plug 'vim-scripts/argtextobj.vim'
Plug 'michaeljsmith/vim-indent-object'

" Lang
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'plasticboy/vim-markdown'
Plug 'slim-template/vim-slim'
Plug 'jnwhiteh/vim-golang'
Plug 'junegunn/vim-redis'
Plug 'vim-scripts/VimClojure'
Plug 'Glench/Vim-Jinja2-Syntax'
" Plug 'kien/rainbow_parentheses.vim'
Plug 'ap/vim-css-color'

" Visual
Plug 'Yggdroot/indentLine'
Plug 'junegunn/vim-scroll-position'

" Colors
Plug 'junegunn/seoul256.vim'
" Plug 'junegunn/jellybeans.vim'
" Plug 'junegunn/Zenburn'
" Plug 'summerfruit256.vim'
Plug 'beauty256'

endif
""""""""""""""""""""""""""""""""""""""""
" End of vim-plug block
""""""""""""""""""""""""""""""""""""""""

let mapleader = ","
let maplocalleader = " "

syntax on

set nu
set autoindent
set smartindent
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

" %< Where to truncate
" %n buffer number
" %F Full path
" %m Modified flag: [+], [-]
" %r Readonly flag: [RO]
" %y Type:          [vim]
" fugitive#statusline()
" %= Separator
" %-14.(...)
" %l Line
" %c Column
" %V Virtual column
" %P Percentage
" %#HighlightGroup#
set statusline=%<[%n]\ %F\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}%=%-14.(%l,%c%V%)\ %P
" function! CursorPosition(width)
"   let lines = line('$')
"   let cline = line('.')
"   let pct   = float2nr(a:width * 1.0 * cline / lines)
"   return '|' . repeat('-', pct) . '>'
" endfunction
" set statusline=%<[%n]\ %F\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}%=%14.(%l,%c%V%)\ %-12{CursorPosition(10)}%P
set pastetoggle=<Ins>
set pastetoggle=<F9> " For Mac
set modelines=2
set synmaxcol=160

" For MacVim
set noimd
set imi=1
set ims=-1

" ctags
set tags=./tags;/

" Annoying temporary files
set backupdir=/tmp,.
set directory=/tmp,.

" Shift-tab on GNU screen
" http://superuser.com/questions/195794/gnu-screen-shift-tab-issue
set t_kB=[Z

" set complete=.,w,b,u,t
set complete-=i

" Color setting
silent! colo seoul256

" mouse
set ttymouse=xterm2
set mouse=a

" Googling
" set keywordprg=open\ http://www.google.com/search?q=\

" 80 chars/line
set textwidth=0
set colorcolumn=80

" Keep the cursor on the same column
set nostartofline

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
    vnoremap <C-c> "*y
    " Clipboard-RTF
    vnoremap <S-c> <esc>:colo seoul256-light<cr>gv:CopyRTF<cr>:colo seoul256<cr>
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
" noremap  <silent> <Enter> :set hls!<cr>:set hls?<cr>
noremap  fnr     :<C-U>.,$s#<C-R><C-W>##gc<Left><Left><Left>
vnoremap fnr     y:<C-U>.,$s#<C-R>"##gc<Left><Left><Left>

" Star-search without moving
noremap  <silent> * viwo<esc>:<C-U>let @/ = '\V\<'.expand('<cword>').'\>'<cr>:set hls<cr>
vnoremap <silent> * y:<C-U>let @/ = '\V'.@"<cr>:set hls<cr>

" Circular windows navigation
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" Clear search highlights
noremap <silent><localleader>/ :nohl<CR>

" Headings
noremap <leader>1 yypVr=
noremap <leader>2 yypVr-

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
let g:scroll_position_auto_enable = 0
" call scroll_position#show()

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" vim-easy-align
let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ '/': { 'pattern': '//\+\|/\*\|\*/', 'ignores': ['String'] },
\ '#': { 'pattern': '#\+', 'ignores': ['String'] },
\ ']': {
\     'pattern':       '[[\]]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       '[()]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   },
\ 'f': {
\     'pattern': ' \(\S\+(\)\@=',
\     'left_margin': 0,
\     'right_margin': 0
\   },
\ 'd': {
\     'pattern': ' \(\S\+\s*[;=]\)\@=',
\     'left_margin': 0,
\     'right_margin': 0
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

function! s:coerce()
  " snake_case -> kebab-case -> camelCase -> MixedCase
  let word = @"
  if word =~# '^[a-z0-9_]\+[!?]\?$'
    let @" = substitute(word, '_', '-', 'g')
  elseif word =~# '^[a-z0-9?!-]\+[!?]\?$'
    let @" = substitute(word, '\C-\([^-]\)', '\u\1', 'g')
  elseif word =~# '^[a-z0-9]\+\([A-Z][a-z0-9]*\)\+[!?]\?$'
    let @" = toupper(word[0]) . strpart(word, 1)
  elseif word =~# '^\([A-Z][a-z0-9]*\)\{2,}[!?]\?$'
    let @" = strpart(substitute(word, '\C\([A-Z]\)', '_\l\1', 'g'), 1)
  else
    normal gv
  endif

  let e = col("'>") + len(@") - len(word)
  execute "normal gv\"_c\<C-R>\"\<esc>".col("'<"). "|v" . e . '|'
endfunction
vnoremap <silent> <tab> y:call <sid>coerce()<cr>

function! SyntaxInclude(lang, b, e, inclusive)
  let syns = split(globpath(&rtp, "syntax/".a:lang.".vim"), "\n")
  if empty(syns)
    return
  endif

  let csyn = b:current_syntax
  unlet b:current_syntax

  let z = "'" " Default
  for nr in range(char2nr('a'), char2nr('z'))
    let char = nr2char(nr)
    if a:b !~ char && a:e !~ char
      let z = char
      break
    endif
  endfor

  silent! exec printf("syntax include @%s %s", a:lang, syns[0])
  if a:inclusive
    exec printf('syntax region %sSnip start=%s\(\)\(%s\)\@=%s end=%s\(%s\)\@<=\(\)%s contains=@%s containedin=ALL',
                \ a:lang, z, a:b, z, z, a:e, z, a:lang)
  else
    exec printf('syntax region %sSnip matchgroup=Snip start=%s%s%s end=%s%s%s contains=@%s containedin=ALL',
                \ a:lang, z, a:b, z, z, a:e, z, a:lang)
  endif

  let b:current_syntax = csyn
endfunction

function! FileTypeHandler()
  if &ft =~ 'jinja' && &ft != 'jinja'
    call SyntaxInclude('jinja', '{{', '}}', 1)
    call SyntaxInclude('jinja', '{%', '%}', 1)
  elseif &ft == 'mkd' || &ft == 'markdown'
    for lang in ['ruby', 'yaml', 'vim', 'sh', 'python', 'java', 'c']
      call SyntaxInclude(lang, '```'.lang, '```', 0)
    endfor

    if &background == 'light'
      highlight def Snip ctermfg=231
    else
      highlight def Snip ctermfg=232
    endif
    set textwidth=80
  endif
endfunction

function! SaveMacro(name, file)
  let content = eval('@'.a:name)
  if !empty(content)
    call writefile(split(content, "\n"), a:file)
    echom len(content) . " bytes save to ". a:file
  endif
endfunction
command! -nargs=* SaveMacro call SaveMacro(<f-args>)

function! LoadMacro(file, name)
  execute 'let @'.a:name.' = join(readfile(a:file), "\n")'
  echom "Macro loaded to @". a:name
endfunction
command! -nargs=* LoadMacro call LoadMacro(<f-args>)

function! HL()
  echo synIDattr(synID(line('.'), col('.'), 0), 'name')
endfunction
command! HL call HL()

function! s:adjust_indentation(idt) range
  let [min, max, range] = [10000, 0, range(a:firstline, a:lastline)]
  for l in range
    let line = getline(l)
    if empty(line) | continue | endif
    let ilen = len(matchstr(line, '^\s\+'))
    let [min, max] = [min([ilen, min]), max([ilen, max])]
  endfor
  let idt = repeat(' ', a:idt == 'd' ? max : (a:idt == 's' ? min : 0))
  for l in range
    let line = getline(l)
    if empty(line) | continue | endif
    call setline(l, substitute(line, '^\s*', idt, ''))
  endfor
endfunction
vnoremap <silent> id :call <sid>adjust_indentation('d')<cr>
vnoremap <silent> in :call <sid>adjust_indentation('n')<cr>
vnoremap <silent> is :call <sid>adjust_indentation('s')<cr>

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

  au Filetype slim hi def link slimBegin NONE
  au Filetype,ColorScheme * call FileTypeHandler()

  au FileType clojure
    \ let vimclojure#ParenRainbow    = 1                     |
    \ let vimclojure#WantNailgun     = 1                     |
    \ let vimclojure#NailgunClient   = $HOME."/bin/ng"       |
    \ let vimclojure#SearchThreshold = 30                    |
    \ map <LocalLeader><LocalLeader> va)*``gv<LocalLeader>eb |
    \ set isk+="-?"

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

