" ============================================================================
" .vimrc of Junegunn Choi
" ============================================================================

" ============================================================================
" VIM-PLUG BLOCK
" ============================================================================

let s:darwin = has("unix") && system("uname") == "Darwin\n"
let $GIT_SSL_NO_VERIFY = 'true'

silent! call plug#init()
if exists(':Plug')

" Edit
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tomtom/tcomment_vim'
Plug 'ervandew/supertab'
Plug 'junegunn/vim-easy-align'
" Plug 'tpope/vim-abolish'
" Plug 'kshenoy/vim-signature'
if s:darwin
  Plug 'zerowidth/vim-copy-as-rtf'
endif

" Tmux
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-dispatch'

" Browsing
" Plug 'a.vim'
" Plug 'grep.vim'
Plug 'mileszs/ack.vim'
Plug 'kien/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
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
" Plug 'junegunn/vim-redis'
Plug 'vim-scripts/VimClojure'
Plug 'Glench/Vim-Jinja2-Syntax'
" Plug 'kien/rainbow_parentheses.vim'
Plug 'ap/vim-css-color'

" Visual
" Plug 'Yggdroot/indentLine'
" Plug 'junegunn/vim-scroll-position'

" Colors
Plug 'junegunn/seoul256.vim'
" Plug 'junegunn/jellybeans.vim'
" Plug 'junegunn/Zenburn'
" Plug 'summerfruit256.vim'
Plug 'beauty256'

endif


" ============================================================================
" Basic settings
" ============================================================================

let mapleader = " "
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
set list
set listchars=tab:\|\ ,

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


" ============================================================================
" MAPPING
" ============================================================================

" ----------------------------------------------------------------------------
" Basic mappings
" ----------------------------------------------------------------------------

noremap ^[[6~ ^D
noremap ^[[5~ ^U

noremap ^[[B ^E
noremap ^[[A ^Y

noremap <C-F> <C-D>
noremap <C-B> <C-U>

" Save
inoremap <C-s> <C-O>:update<cr>
nnoremap  <C-s> :update<cr>

" Select-all (don't need confusing increment C-a)
noremap  <C-a> gg0vG$

" Quit
inoremap <C-Q> <esc>:q<cr>
nnoremap  <C-Q> :q<cr>
vnoremap <C-Q> <esc>

" Jump list
nnoremap g[ <C-o>
nnoremap g] <C-i>

" <F10> | NERD Tree
inoremap <F10> <esc>:NERDTreeToggle<cr>
nnoremap  <F10> :NERDTreeToggle<cr>

" <F11> | Tagbar
inoremap <F11> <esc>:TagbarToggle<cr>
nnoremap  <F11> :TagbarToggle<cr>
let g:tagbar_sort = 0

" <F12> Toggle line number display
nnoremap <F12> :set nonumber!<cr>

" jk | Escaping!
noremap! jk <C-c>
vnoremap jk <C-c>

" No delay in visual mode by jk
vnoremap v <down>
vnoremap V <down>

" Movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-^> <C-o><C-^>

" Make Y behave like other capitals
nnoremap Y y$

" qq to record, Q to replay
nnoremap Q @q

"
"n
" For screencasting with Keycastr
" map <tab> <nop>
" imap <tab> <nop>
" vmap <tab> <nop>

" ----------------------------------------------------------------------------
" fnr | Find and replace
" ----------------------------------------------------------------------------
nnoremap fnr :<C-U>.,$s#<C-R><C-W>##gc<Left><Left><Left>
vnoremap fnr y:<C-U>.,$s#<C-R>"##gc<Left><Left><Left>

" ----------------------------------------------------------------------------
" * | Star-search without moving
" ----------------------------------------------------------------------------
nnoremap <silent> * viwo<esc>:<C-U>let @/ = '\V\<'.expand('<cword>').'\>'<cr>:set hls<cr>
vnoremap <silent> * y:<C-U>let @/ = '\V'.@"<cr>:set hls<cr>

" ----------------------------------------------------------------------------
" <tab> / <s-tab> | Circular windows navigation
" ----------------------------------------------------------------------------
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" ----------------------------------------------------------------------------
" Clear search highlights
" ----------------------------------------------------------------------------
nnoremap <silent><leader>/ :nohl<CR>

" ----------------------------------------------------------------------------
" Markdown headings
" ----------------------------------------------------------------------------
nnoremap <leader>1 m`yypVr=``
nnoremap <leader>2 m`yypVr-``
nnoremap <leader>3 m`^i### <esc>``4l
nnoremap <leader>4 m`^i#### <esc>``5l
nnoremap <leader>5 m`^i##### <esc>``6l

" ----------------------------------------------------------------------------
" Moving lines
" ----------------------------------------------------------------------------
nnoremap  <silent> <C-k> :execute ":move ".max([0,         line('.') - 2])<cr>
nnoremap  <silent> <C-j> :execute ":move ".min([line('$'), line('.') + 1])<cr>
nnoremap  <silent> <C-h> <<
nnoremap  <silent> <C-l> >>
vnoremap <silent> <C-k> :<C-U>execute "normal! gv:move ".max([0,         line("'<") - 2])."\n"<cr>gv
vnoremap <silent> <C-j> :<C-U>execute "normal! gv:move ".min([line('$'), line("'>") + 1])."\n"<cr>gv
vnoremap <silent> <C-h> <gv
vnoremap <silent> <C-l> >gv
vnoremap < <gv
vnoremap > >gv

" ----------------------------------------------------------------------------
" Cscope mappings
" ----------------------------------------------------------------------------
if has("cscope")
  set csprg=/usr/local/bin/cscope
  set csto=0
  set cst
  set nocsverb
  " add any database in current directory
  let db = findfile('cscope.out', '.;')
  if !empty(db)
    execute "cs add ".db
  " else add database pointed to by environment
  elseif !empty($CSCOPE_DB)
    execute "cs add ".$CSCOPE_DB
  endif
  unlet db
  set csverb

  "   's'   symbol: find all references to the token under cursor
  "   'g'   global: find global definition(s) of the token under cursor
  "   'c'   calls:  find all calls to the function name under cursor
  "   't'   text:   find all instances of the text under cursor
  "   'e'   egrep:  egrep search for the word under cursor
  "   'f'   file:   open the filename under cursor
  "   'i'   includes: find files that include the filename under cursor
  "   'd'   called: find functions that function under cursor calls
  nnoremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nnoremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nnoremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  nnoremap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif


" ============================================================================
" FUNCTIONS & COMMANDS
" ============================================================================

" ----------------------------------------------------------------------------
" :Chomp
" ----------------------------------------------------------------------------
command! Chomp silent! normal! :%s/\s\+$//<cr>

" ----------------------------------------------------------------------------
" R | Replace
" ----------------------------------------------------------------------------
function! s:replace()
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
vnoremap R :<C-U>call <SID>replace()<cr>

" ----------------------------------------------------------------------------
" Tmux navigation (disabled)
" ----------------------------------------------------------------------------
" - http://www.codeography.com/2013/06/19/navigating-vim-and-tmux-splits.html
" if exists('$TMUX')
"   function! tmux_or_split_switch(wincmd, tmuxdir, prev)
"     execute "wincmd " . a:wincmd
"     if a:prev == winnr()
"       " The sleep and & gives time to get back to vim so tmux's focus tracking
"       " can kick in and send us our ^[[O
"       execute "silent !sh -c 'sleep 0.01; tmux select-pane -" . a:tmuxdir . "' &"
"       redraw!
"     endif
"   endfunction
"   let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
"   let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
"   let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te
"   nnoremap <silent> \h     :call <SID>tmux_or_split_switch('h', 'L', winnr())<cr>
"   nnoremap <silent> \j     :call <SID>tmux_or_split_switch('j', 'D', winnr())<cr>
"   nnoremap <silent> \k     :call <SID>tmux_or_split_switch('k', 'U', winnr())<cr>
"   nnoremap <silent> \l     :call <SID>tmux_or_split_switch('l', 'R', winnr())<cr>
"   nnoremap <silent> \<tab> :call <SID>tmux_or_split_switch('w', 't :.+', 1)<cr>
" endif

" ----------------------------------------------------------------------------
" <F5> / <F6> | Run script
" ----------------------------------------------------------------------------
function! s:run_this_script(output)
  let head  = getline(1)
  let pos   = stridx(head, '#!')
  let file  = expand('%:p')
  let ofile = tempname()
  let rdr   = " 2>&1 | tee ".ofile
  " She-bang found
  if pos != -1
    execute '!'.strpart(head, pos + 2).' '.file.rdr
  " She-bang not found but executable
  elseif executable(file)
    execute '!'.file.rdr
  elseif &filetype == 'ruby'
    execute '!/usr/bin/env ruby '.file.rdr
  elseif &filetype == 'tex'
    execute '!latex '.file. '; [ $? -eq 0 ] && xdvi '. expand('%:r').rdr
  elseif &filetype == 'dot'
    let svg = expand('%:r') . '.svg'
    let png = expand('%:r') . '.png'
    execute '!dot -Tsvg '.file.' -o '.svg.' && '
          \ 'mogrify -density 300 -format png '.svg.' && open '.png.rdr
  else
    return
  end
  if !a:output | return | endif

  " Scratch buffer
  execute get(s:, 'vim_exec_win', 0) . 'wincmd w'
  if exists('b:vim_exec_win')
    %d
  else
    let      sr = &splitright
    set      splitright
    silent!  bdelete [vim-exec-output]
    silent!  100vnew
    silent!  file [vim-exec-output]
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    set      nowrap
    let      b:vim_exec_win = 1
    let      s:vim_exec_win = winnr()
    if !sr
      set nosplitright
    endif
  endif
  execute  "silent! read ".ofile
  normal!  gg"_dd
  execute  "normal! \<C-W>p"
endfunction
inoremap <silent> <F5> <esc>:call <SID>run_this_script(0)<cr>
nnoremap <silent> <F5> :call <SID>run_this_script(0)<cr>
inoremap <silent> <F6> <esc>:call <SID>run_this_script(1)<cr>
nnoremap <silent> <F6> :call <SID>run_this_script(1)<cr>

" ----------------------------------------------------------------------------
" <F8> | Color scheme selector
" ----------------------------------------------------------------------------
function! s:rotate_colors()
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
nnoremap <F8> :call <SID>rotate_colors()<cr>

" ----------------------------------------------------------------------------
" :Shuffle | Shuffle selected lines
" ----------------------------------------------------------------------------
function! s:shuffle()
ruby << EOF
  buf = VIM::Buffer.current
  firstnum = VIM::evaluate('a:firstline').to_i
  lastnum = VIM::evaluate('a:lastline').to_i
  (firstnum..lastnum).map { |l| buf[l] }.shuffle.each_with_index do |line, i|
    buf[firstnum + i] = line
  end
EOF
endfunction
command! -range Shuffle <line1>,<line2>call s:shuffle()

" ----------------------------------------------------------------------------
" <tab> | Case conversion
" ----------------------------------------------------------------------------
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

" ----------------------------------------------------------------------------
" Syntax highlighting in code snippets
" ----------------------------------------------------------------------------
function! s:syntax_include(lang, b, e, inclusive)
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
    exec printf('syntax region %sSnip start=%s\(\)\(%s\)\@=%s ' .
                \ 'end=%s\(%s\)\@<=\(\)%s contains=@%s containedin=ALL',
                \ a:lang, z, a:b, z, z, a:e, z, a:lang)
  else
    exec printf('syntax region %sSnip matchgroup=Snip start=%s%s%s ' .
                \ 'end=%s%s%s contains=@%s containedin=ALL',
                \ a:lang, z, a:b, z, z, a:e, z, a:lang)
  endif

  let b:current_syntax = csyn
endfunction

function! s:file_type_handler()
  if &ft =~ 'jinja' && &ft != 'jinja'
    call s:syntax_include('jinja', '{{', '}}', 1)
    call s:syntax_include('jinja', '{%', '%}', 1)
  elseif &ft == 'mkd' || &ft == 'markdown'
    for lang in ['ruby', 'yaml', 'vim', 'sh', 'python', 'java', 'c']
      call s:syntax_include(lang, '```'.lang, '```', 0)
    endfor

    if &background == 'light'
      highlight def Snip ctermfg=231
    else
      highlight def Snip ctermfg=232
    endif
    set textwidth=80
  endif
endfunction

" ----------------------------------------------------------------------------
" SaveMacro / LoadMacro
" ----------------------------------------------------------------------------
function! s:save_macro(name, file)
  let content = eval('@'.a:name)
  if !empty(content)
    call writefile(split(content, "\n"), a:file)
    echom len(content) . " bytes save to ". a:file
  endif
endfunction
command! -nargs=* SaveMacro call <SID>save_macro(<f-args>)

function! s:load_macro(file, name)
  execute 'let @'.a:name.' = join(readfile(a:file), "\n")'
  echom "Macro loaded to @". a:name
endfunction
command! -nargs=* LoadMacro call <SID>load_macro(<f-args>)

" ----------------------------------------------------------------------------
" HL | Find out syntax group
" ----------------------------------------------------------------------------
function! s:hl()
  echo synIDattr(synID(line('.'), col('.'), 0), 'name')
endfunction
command! HL call <SID>hl()

" ----------------------------------------------------------------------------
" (v) id / in / is | Indentation adjustment
" ----------------------------------------------------------------------------
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

" ----------------------------------------------------------------------------
" :A
" ----------------------------------------------------------------------------
function! s:a()
  let name = expand('%:r')
  let ext = tolower(expand('%:e'))
  let sources = ['c', 'cc', 'cpp', 'cxx']
  let headers = ['h', 'hh', 'hpp', 'hxx']
  for pair in [[sources, headers], [headers, sources]]
    let [set1, set2] = pair
    if index(set1, ext) >= 0
      for h in set2
        let aname = name.'.'.h
        for a in [aname, toupper(aname)]
          if filereadable(a)
            execute "e ".a
            return
          end
        endfor
      endfor
    endif
  endfor
endfunction
command! A call s:a()

" ----------------------------------------------------------------------------
" <leader>f | fuzzy matching
" ----------------------------------------------------------------------------
function! s:fuzzy_matching_pattern(str)
  let chars = split(a:str, '\s*')
  return join(
        \ extend(map(chars[0 : -2], 'v:val . "[^" .v:val. "]\\{-}"'),
        \ chars[-1:-1]), '')
endfunction

function! s:fuzzy_matching()
  let str = ''
  let prev = @/
  while 1
    echon "\r/". str

    let c = getchar()
    let ch = nr2char(c)

    if c == 3 || c == 27 || (c == "\<bs>" && len(str) == 1)
      echon "\r".repeat(' ', len(str) + 1)
      let @/ = prev
      nohl
      break
    elseif ch == "\<Enter>"
      normal! n
      break
    elseif ch == "\<C-U>"
      let str = ''
    elseif c == "\<bs>"
      let str = str[0 : -2]
    else
      let str .= ch
    endif
    let @/ = s:fuzzy_matching_pattern(str)
    set hls
    echon "\r/". str
    redraw
  endwhile
endfunction
nnoremap <silent> <leader>f :call <SID>fuzzy_matching()<cr>


" ============================================================================
" PLUGINS
" ============================================================================

" ----------------------------------------------------------------------------
" vim-ruby (https://github.com/vim-ruby/vim-ruby/issues/33)
" ----------------------------------------------------------------------------
if !empty(matchstr($MY_RUBY_HOME, 'jruby'))
  let g:ruby_path = join(split(
    \ glob($MY_RUBY_HOME.'/lib/ruby/*.*')."\n".
    \ glob($MY_RUBY_HOME.'/lib/rubysite_ruby/*'),"\n"), ',')
endif

" ----------------------------------------------------------------------------
" vim-textobj-rubyblock
" ----------------------------------------------------------------------------
runtime macros/matchit.vim

" ----------------------------------------------------------------------------
" vim-scroll-position
" ----------------------------------------------------------------------------
" let g:scroll_position_jump = '-'
" let g:scroll_position_change = 'x'
" let g:scroll_position_auto_enable = 0
" let g:scroll_position_auto_enable = 0
" call scroll_position#show()

" ----------------------------------------------------------------------------
" Ctrl-P
" ----------------------------------------------------------------------------
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_max_height = 30
let g:ctrlp_extensions = ['funky']
nnoremap <C-P><C-P> :CtrlPBuffer<cr>
nnoremap <C-P><C-F> :CtrlPFunky<cr>

" ----------------------------------------------------------------------------
" supertab
" ----------------------------------------------------------------------------
let g:SuperTabDefaultCompletionType = "<c-n>"

" ----------------------------------------------------------------------------
" vim-copy-as-rtf
" ----------------------------------------------------------------------------
if s:darwin
  " Clipboard
  vnoremap <C-c> "*y
  " Clipboard-RTF
  vnoremap <S-c> <esc>:colo seoul256-light<cr>gv:CopyRTF<cr>:colo seoul256<cr>
endif

" ----------------------------------------------------------------------------
" <Enter> | vim-easy-align
" ----------------------------------------------------------------------------
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

" ----------------------------------------------------------------------------
" vim-github-dashboard
" ----------------------------------------------------------------------------
let g:github_dashboard = { 'username': 'junegunn' }

" ----------------------------------------------------------------------------
" vim-redis
" ----------------------------------------------------------------------------
" " let g:vim_redis_host = 'localhost'
" " let g:vim_redis_port = '6379'
" " let g:vim_redis_auth = 'xxx'
" let g:vim_redis_paste_command = 1
" let g:vim_redis_paste_command_prefix = '> '
" nnoremap <silent> <leader>re :RedisExecute<cr>
" vnoremap <silent> <leader>re :RedisExecuteVisual<cr>gv
" nnoremap <silent> <leader>rw :RedisWipe<cr>
" nnoremap <silent> <leader>rq :RedisQuit<cr>

" ----------------------------------------------------------------------------
" <leader>t | vim-tbone
" ----------------------------------------------------------------------------
function! s:tmux_send() range
  echon "To which pane? (t = .1) "
  let char = getchar()
  if char == 116
    let target = '.1'
  else
    let target = nr2char(char)
  endif
  silent call tbone#write_command(0, a:firstline, a:lastline, 1, target)
endfunction
nnoremap <silent> <leader>t :call <SID>tmux_send()<cr>
vnoremap <silent> <leader>t :call <SID>tmux_send()<cr>

" ----------------------------------------------------------------------------
" gt / q | Help in new tabs
" ----------------------------------------------------------------------------

function! s:helptab()
  if &buftype == 'help'
    execute "normal! \<C-W>T"
    nnoremap q :q<cr>
  endif
endfunction

augroup helptxt
  autocmd!
  autocmd BufEnter *.txt call s:helptab()
augroup END

" ============================================================================
" AUTOCMD
" ============================================================================

augroup vimrc
  autocmd!

  au BufRead              *                   setlocal foldmethod=manual
  au BufRead              *                   setlocal nofoldenable
  au BufWritePost         .vimrc              source %

  au BufNewFile,BufRead   [Cc]apfile          set filetype=ruby
  au BufNewFile,BufRead   *.md                set filetype=markdown
  au BufNewFile,BufRead   *.icc               set filetype=cpp
  au BufNewFile,BufRead   *.pde               set filetype=java
  au BufNewFile,BufRead   *.less              set filetype=less
  au BufNewFile,BufRead   *.god               set filetype=ruby
  au BufNewFile,BufRead   *.coffee-processing set filetype=coffee

  au Filetype slim hi def link slimBegin NONE
  au Filetype,ColorScheme * call <SID>file_type_handler()

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

