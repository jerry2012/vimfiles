" ============================================================================
" .vimrc of Junegunn Choi
" ============================================================================

let s:darwin = has('mac')
let s:ag     = executable('ag')

" ============================================================================
" VIM-PLUG BLOCK
" ============================================================================

silent! if plug#begin('~/.vim/plugged')

if s:darwin
  Plug 'git@github.com:junegunn/vim-easy-align.git'
  Plug 'git@github.com:junegunn/vim-emoji.git'
  Plug 'git@github.com:junegunn/vim-github-dashboard.git',
                         \ { 'on': ['GHDashboard', 'GHActivity'] }
  Plug 'git@github.com:junegunn/vim-fnr.git'
  Plug 'git@github.com:junegunn/seoul256.vim.git'
  Plug 'git@github.com:junegunn/vader.vim.git',  { 'on': 'Vader' }
  Plug 'git@github.com:junegunn/fzf.git',        { 'on': 'FZF'   }
  Plug 'git@github.com:junegunn/vim-ruby-x.git', { 'on': 'RubyX' }
  Plug 'git@github.com:junegunn/goyo.vim.git',   { 'on': 'Goyo'  }
" Plug 'git@github.com:junegunn/vim-scroll-position.git'
" Plug 'git@github.com:junegunn/vim-redis.git'
" Plug 'git@github.com:junegunn/jellybeans.vim.git'
" Plug 'git@github.com:junegunn/Zenburn.git'
else
  let $GIT_SSL_NO_VERIFY = 'true'
  Plug 'junegunn/vim-easy-align'
  Plug 'junegunn/vim-github-dashboard', { 'on': ['GHDashboard', 'GHActivity'] }
  Plug 'junegunn/vim-fnr'
  Plug 'junegunn/seoul256.vim'
  Plug 'junegunn/vader.vim',  { 'on': 'Vader' }
  Plug 'junegunn/fzf',        { 'on': 'FZF'   }
  Plug 'junegunn/vim-ruby-x', { 'on': 'RubyX' }
  Plug 'junegunn/goyo.vim',   { 'on': 'Goyo'  }
endif

" Edit
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tomtom/tcomment_vim'
Plug 'ervandew/supertab',  { 'on': '<Plug>SuperTab' }
Plug 'kovisoft/paredit'
Plug 'mbbill/undotree',    { 'on': 'UndotreeToggle' }
Plug 'justinmk/vim-sneak', { 'on': '<Plug>Sneak'    }
Plug 'kshenoy/vim-signature'
if s:darwin
  Plug 'zerowidth/vim-copy-as-rtf'
endif

" Tmux
Plug 'tpope/vim-tbone'

" Browsing
Plug 'kien/ctrlp.vim'
Plug 'mileszs/ack.vim',     { 'on': 'Ack' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
if v:version >= 703
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
endif

" Git
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv', { 'on': 'Gitv' }
if v:version >= 703
  Plug 'airblade/vim-gitgutter'
else
  Plug 'mhinz/vim-signify'
endif

" Lang
if v:version >= 703
  Plug 'vim-ruby/vim-ruby'
  Plug 'vim-scripts/VimClojure'
endif
Plug 'tpope/vim-rails'
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'plasticboy/vim-markdown'
Plug 'slim-template/vim-slim'
Plug 'Glench/Vim-Jinja2-Syntax'
if s:darwin
  Plug 'Keithbsmiley/investigate.vim'
endif
Plug 'AndrewRadev/sideways.vim'

Plug 'minibufexpl.vim'
Plug 'mru.vim'
Plug 'a.vim'

call plug#end()
endif

" ============================================================================
" Basic settings
" ============================================================================

"let mapleader = " "
"let maplocalleader = " "
let mapleader = ","
let maplocalleader = ","

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
set shortmess+=T
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
set virtualedit=block
set nojoinspaces

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
set statusline=%<[%n]\ %F\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %=%-14.(%l,%c%V%)\ %P
silent! if emoji#available()
  set statusline=%{emoji#for('cherry_blossom')}\ %<[%n]\ %F\ %{MyModified()}%{MyReadonly()}%{MyFileType()}\ %{MyFugitiveHead()}\ %=%-14.(%l,%c%V%)\ %P\ %{MyClock()}

  let s:ft_emoji = map({
    \ 'c':          'baby_chick',
    \ 'clojure':    'lollipop',
    \ 'coffee':     'coffee',
    \ 'cpp':        'chicken',
    \ 'css':        'art',
    \ 'eruby':      'ring',
    \ 'gitcommit':  'soon',
    \ 'haml':       'hammer',
    \ 'help':       'angel',
    \ 'html':       'herb',
    \ 'java':       'older_man',
    \ 'javascript': 'monkey',
    \ 'make':       'seedling',
    \ 'markdown':   'book',
    \ 'perl':       'camel',
    \ 'python':     'snake',
    \ 'ruby':       'gem',
    \ 'scala':      'barber',
    \ 'sh':         'shell',
    \ 'slim':       'dancer',
    \ 'text':       'books',
    \ 'vim':        'poop',
    \ 'vim-plug':   'electric_plug',
    \ 'yaml':       'yum',
    \ 'yaml.jinja': 'yum'
  \ }, 'emoji#for(v:val)')

  function! MyFileType()
    if empty(&filetype)
      return emoji#for('grey_question')
    else
      return get(s:ft_emoji, &filetype, '['.&filetype.']')
    endif
  endfunction

  function! MyModified()
    if &modified
      return emoji#for('kiss').' '
    elseif !&modifiable
      return emoji#for('construction').' '
    else
      return ''
    endif
  endfunction

  function! MyReadonly()
    return &readonly ? emoji#for('lock') . ' ' : ''
  endfunction

  function! MyFugitiveHead()
    let head = fugitive#head()
    if empty(head)
      return ''
    else
      return head == 'master' ? emoji#for('crown') : emoji#for('dango').'='.head
    endif
  endfunction

  function! MyClock()
    let h = substitute(strftime('%l'), ' ', '', '')
    let m = strftime('%M')
    if m < 15
      let m = ''
    elseif m >= 15 && m < 45
      let m = 30
    elseif m >= 45
      let h = str2nr(h) + 1
      let h = h > 12 ? 1 : h
      let m = ''
    endif
    return emoji#for('clock'.h.m, h.m)
  endfunction
endif

set pastetoggle=<Ins>
"set pastetoggle=<F9> " For Mac
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
if exists('&colorcolumn')
  set colorcolumn=80
endif

" Keep the cursor on the same column
set nostartofline


" ============================================================================
" MAPPINGS
" ============================================================================

" ----------------------------------------------------------------------------
" Basic mappings
" ----------------------------------------------------------------------------

noremap <C-F> <C-D>
noremap <C-B> <C-U>

" Save
inoremap <C-s> <C-O>:update<cr>
nnoremap <C-s> :update<cr>

" Select-all (don't need confusing increment C-a)
noremap  <C-a> gg0vG$

" Quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>

" Tag stack
nnoremap g<Left>  :pop<cr>
nnoremap g<Right> :tag<cr>

" Jump list
nnoremap g<Up>    <C-o>
nnoremap g<Down>  <C-i>

" <F8> | NERD Tree
inoremap <F8> <esc>:NERDTreeToggle<cr>
nnoremap <F8> :NERDTreeToggle<cr>

" <F9> | Tagbar
if v:version >= 703
  inoremap <F9> <esc>:TagbarToggle<cr>
  nnoremap <F9> :TagbarToggle<cr>
  let g:tagbar_sort = 0
endif

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

" ----------------------------------------------------------------------------
" * | Star-search without moving
" ----------------------------------------------------------------------------
nnoremap <silent> *    :<C-U>let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>wb
vnoremap <silent> * "xy:<C-U>let @/ = '\V'.  escape(@x,                '\')<cr>:set hls<cr>

" ----------------------------------------------------------------------------
" <tab> / <s-tab> | Circular windows navigation
" ----------------------------------------------------------------------------
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" ----------------------------------------------------------------------------
" Clear search highlights
" ----------------------------------------------------------------------------
nnoremap <silent> <leader>/ :nohl<CR>

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
nnoremap <silent> <C-k> :execute ":move ".max([0,         line('.') - 2])<cr>
nnoremap <silent> <C-j> :execute ":move ".min([line('$'), line('.') + 1])<cr>
nnoremap <silent> <C-h> <<
nnoremap <silent> <C-l> >>
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
  "set csprg=/usr/local/bin/cscope
  set csprg=/usr/bin/cscope
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

" ----------------------------------------------------------------------------
" <Leader>c Counting occurrences of the pattern
" ----------------------------------------------------------------------------
vnoremap <Leader>c :s@\%V@@gn<Left><Left><Left><Left>
nnoremap <Leader>c :%s@@@gn<Left><Left><Left><Left>

" ----------------------------------------------------------------------------
" Readline-style key binding in command-line (excerpt from rsi.vim)
" ----------------------------------------------------------------------------
cnoremap        <C-A> <Home>
cnoremap        <C-B> <Left>
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
cnoremap        <M-b> <S-Left>
cnoremap        <M-f> <S-Right>
silent! exe "set <S-Left>=\<Esc>b"
silent! exe "set <S-Right>=\<Esc>f"

" ----------------------------------------------------------------------------
" #gi / #gpi | go to next/previous indentation level
" ----------------------------------------------------------------------------
function! s:go_indent(times, dir)
  for _ in range(a:times)
    let l = line('.')
    let x = line('$')
    let i = s:indent_len(getline(l))
    let e = empty(getline(l))

    while l >= 1 && l <= x
      let line = getline(l + a:dir)
      let l += a:dir
      if s:indent_len(line) != i || empty(line) != e
        break
      endif
    endwhile
    let l = min([max([1, l]), x])
    execute 'normal! '. l .'G^'
  endfor
endfunction
nnoremap <silent> gi :<c-u>call <SID>go_indent(v:count1, 1)<cr>
nnoremap <silent> gpi :<c-u>call <SID>go_indent(v:count1, -1)<cr>

" ----------------------------------------------------------------------------
" s / S / gs / gS | Skip motions
" ----------------------------------------------------------------------------
" function! s:skip(times, idx, dst, vis)
"   let pos = [line('.'), col('.')]
"
"   for _ in range(a:times)
"     let pos[a:idx] = (pos[a:idx] + a:dst) / 2
"   endfor
"
"   if !empty(a:vis)
"     execute printf("normal! `<%s`>", a:vis)
"   endif
"   execute printf("normal! %dG%d|", pos[0], pos[1])
" endfunction
"
" nnoremap <silent> s  :<c-u>call <SID>skip(v:count1, 1, col('$'), '')<cr>
" nnoremap <silent> S  :<c-u>call <SID>skip(v:count1, 1, max([match(getline(line('.')), '\S') + 1, 1]), '')<cr>
" nnoremap <silent> gs :<c-u>call <SID>skip(v:count1, 0, line('w$'), '')<cr>
" nnoremap <silent> gS :<c-u>call <SID>skip(v:count1, 0, line('w0'), '')<cr>
" vnoremap <silent> s  <ESC>:call <SID>skip(v:count1, 1, col('$'), visualmode())<cr>
" vnoremap <silent> S  <ESC>:call <SID>skip(v:count1, 1, max([match(getline(line('.')), '\S') + 1, 1]), visualmode())<cr>
"
" for i in range(1, 9)
"   execute printf('nnoremap <silent> g%d ^:execute "normal! ".(%d * (col("$") - col(".")) / 10)."\|"<cr>', i, i)
" endfor

" ============================================================================
" FUNCTIONS & COMMANDS
" ============================================================================

" ----------------------------------------------------------------------------
" :Chomp
" ----------------------------------------------------------------------------
command! Chomp silent! normal! :%s/\s\+$//<cr>

" ----------------------------------------------------------------------------
" :Root | Change directory to the root of the Git repository
" ----------------------------------------------------------------------------
function! s:root()
  let me = expand('%:p:h')
  let gitd = finddir('.git', me.';')
  if empty(gitd)
    echo "Not in Git repo"
  else
    let gitp = fnamemodify(gitd, ':h')
    echo "Change directory to: ".gitp
    execute 'lcd '.gitp
  endif
endfunction
command! Root call s:root()

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
" <F7> | Color scheme selector
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
nnoremap <F7> :call <SID>rotate_colors()<cr>

" ----------------------------------------------------------------------------
" :Shuffle | Shuffle selected lines
" ----------------------------------------------------------------------------
function! s:shuffle() range
ruby << RB
  first, last = %w[a:firstline a:lastline].map { |e| VIM::evaluate(e).to_i }
  (first..last).map { |l| $curbuf[l] }.shuffle.each_with_index do |line, i|
    $curbuf[first + i] = line
  end
RB
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

  if exists('b:current_syntax')
    let csyn = b:current_syntax
    unlet b:current_syntax
  endif

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

  if exists('csyn')
    let b:current_syntax = csyn
  endif
endfunction

function! s:file_type_handler()
  if &ft =~ 'jinja' && &ft != 'jinja'
    call s:syntax_include('jinja', '{{', '}}', 1)
    call s:syntax_include('jinja', '{%', '%}', 1)
  elseif &ft == 'mkd' || &ft == 'markdown'
    let map = { 'bash': 'sh' }
    for lang in ['ruby', 'yaml', 'vim', 'sh', 'bash', 'python', 'java', 'c']
      call s:syntax_include(get(map, lang, lang), '```'.lang, '```', 0)
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
" (v) <c-t>d / <c-t>n / <c-t>s | indenTation adjustment
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
vnoremap <silent> <c-t>d :call <sid>adjust_indentation('d')<cr>
vnoremap <silent> <c-t>n :call <sid>adjust_indentation('n')<cr>
vnoremap <silent> <c-t>s :call <sid>adjust_indentation('s')<cr>

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
function! s:fuzzy_matching(backward)
  set shortmess+=T " required :p
  let prefix = "\rf" . (a:backward ? '?' : '/')
  let search = a:backward ? 'cb' : 'c'
  normal! m`

  try
    let mid = 0
    let q = ''
    while 1
      redraw
      echon prefix . q
      let c  = getchar()
      let ch = nr2char(c)

      if ch == "\<C-C>" || ch == "\<Esc>" || (c == "\<bs>" && len(q) <= 1)
        echon "\r".repeat(' ', len(q) + 2)
        keepjumps normal! ``
        break
      elseif ch == "\<Enter>"    | let @/ = regex | set hls | break
      elseif ch == "\<C-U>"      | let q  = ''
      elseif c  == "\<bs>"       | let q  = q[0 : -2]
      elseif ch =~ '[[:print:]]' | let q .= ch
      else                       | continue
      endif

      let chars = map(split(q, '.\zs'), 'escape(v:val, "\\[]^$.*")')
      let regex = join(
        \ extend(map(chars[0 : -2], 'v:val . "[^" .v:val. "]\\{-}"'),
        \ chars[-1:-1]), '')

      silent! call matchdelete(mid)
      keepjumps normal! ``
      if !empty(regex)
        if search('\c'.regex, search) == 0
          keepjumps normal! ``
        else
          let mid = matchadd("IncSearch", '\c\%'.line('.').'l'.regex)
        endif
      endif
    endwhile
  finally
    silent! call matchdelete(mid)
    redraw
  endtry
endfunction
nnoremap <silent> <leader>f :call <SID>fuzzy_matching(0)<cr>
nnoremap <silent> <leader>F :call <SID>fuzzy_matching(1)<cr>

" ----------------------------------------------------------------------------
" MatchParen delay
" ----------------------------------------------------------------------------
let g:matchparen_insert_timeout=5

" ----------------------------------------------------------------------------
" call LSD()
" ----------------------------------------------------------------------------
function! LSD()
  syntax clear

  for i in range(16, 255)
    execute printf('highlight LSD%s ctermfg=%s', i - 16, i)
  endfor

  let block = 4
  for l in range(1, line('$'))
    let c = 1
    let max = len(getline(l))
    while c < max
      let stride = 4 + reltime()[1] % 8
      execute printf('syntax region lsd%s_%s start=/\%%%sl\%%%sc/ end=/\%%%sl\%%%sc/ contains=ALL', l, c, l, c, l, min([c + stride, max]))
      let rand = abs(reltime()[1] % (256 - 16))
      execute printf('hi def link lsd%s_%s LSD%s', l, c, rand)
      let c += stride
    endwhile
  endfor
endfunction

" ----------------------------------------------------------------------------
" call RandomizeColors()
" ----------------------------------------------------------------------------
function! RandomizeColors()
  let colors = [16, 17, 23, 24, 25, 30, 31, 38, 52, 53, 58, 59, 65, 66, 67,
  \ 68, 71, 73, 74, 88, 89, 95, 96, 101, 102, 103, 107, 108, 109, 110, 113, 116,
  \ 117, 125, 130, 131, 132, 136, 137, 138, 143, 144, 145, 146, 148, 151, 152,
  \ 153, 161, 168, 173, 174, 178, 179, 180, 181, 184, 186, 187, 188, 189, 195,
  \ 208, 209, 216, 217, 218, 220, 221, 222, 223, 224, 230, 231, 238, 252]

  redir => h
  silent hi
  redir END
  for pair in map(filter(split(h, "\n"), 'v:val !~ "link"'),
                  \ '[substitute(v:val, " .*", "", ""), v:val =~ "reverse"]')
    let [g, inv] = pair
    if empty(g) | continue | endif
    let c1 = colors[abs(reltime()[1] % len(colors))]
    if inv
      let c2 = colors[abs(reltime()[1] % len(colors))]
      execute printf("hi %s ctermfg=%d ctermbg=%d", g, c1, c2)
    else
      execute printf("hi %s ctermfg=%d", g, c1)
    endif
  endfor
endfunction


" ============================================================================
" TEXT OBJECTS
" ============================================================================
"
" ----------------------------------------------------------------------------
" ?ii / ?ai | indent-object
" ?io       | strictly-indent-object
" ----------------------------------------------------------------------------
function! s:indent_len(str)
  return len(matchstr(a:str, '^\s*'))
endfunction

function! s:indent_object(op, skip_blank, b, e, bd, ed)
  let i = min([s:indent_len(getline(a:b)), s:indent_len(getline(a:e))])
  let b = i == 0 && empty(getline(a:b)) && empty(getline(a:e))
  let x = line('$')
  let d = [a:b, a:e]
  for triple in [[0, 'd[o] > 1', -1], [1, 'd[o] < x', +1]]
    let [o, ev, df] = triple

    while eval(ev)
      let line = getline(d[o] + df)
      let idt = s:indent_len(line)
      if b && idt > i
        let i = idt
      endif

      if eval('idt '.a:op.' i') || (a:skip_blank && empty(line))
        let d[o] += df
      else | break | end
    endwhile
  endfor
  execute printf('normal! %dGV%dG', max([1, d[0] + a:bd]), min([x, d[1] + a:ed]))
endfunction
vnoremap <silent> ii :<c-u>call <SID>indent_object('>=', 1, line("'<"), line("'>"), 0, 0)<cr>
onoremap <silent> ii :<c-u>call <SID>indent_object('>=', 1, line('.'), line('.'), 0, 0)<cr>
vnoremap <silent> ai :<c-u>call <SID>indent_object('>=', 1, line("'<"), line("'>"), -1, 1)<cr>
onoremap <silent> ai :<c-u>call <SID>indent_object('>=', 1, line('.'), line('.'), -1, 1)<cr>
vnoremap <silent> io :<c-u>call <SID>indent_object('==', 0, line("'<"), line("'>"), 0, 0)<cr>
onoremap <silent> io :<c-u>call <SID>indent_object('==', 0, line('.'), line('.'), 0, 0)<cr>

" ----------------------------------------------------------------------------
" ?i_, ?a_ | underscore_text_object (vT_ot_ / vF_of_)
" ----------------------------------------------------------------------------
function! s:inner_underscore(incl)
  let cursor = col('.')
  let save_x = @x
  normal! "xyiw

  let pos = col(".")
  for token in split(@x, '_\zs')
    let pos += len(token)
    if pos > cursor
      let begin = pos - len(token)
      let end   = pos - (token =~ '_$' && !a:incl ? 2 : 1)
      if a:incl && begin > 1 && getline(line('.'))[begin - 2] == '_'
        let begin -= 1
      endif
      execute printf("normal! %d|v%d|", begin, end)
      break
    endif
  endfor

  let @x = save_x
endfunction

vnoremap <silent> i_ :<C-U>call <SID>inner_underscore(0)<CR>
onoremap <silent> i_ :<C-U>call <SID>inner_underscore(0)<CR>
vnoremap <silent> a_ :<C-U>call <SID>inner_underscore(1)<CR>
onoremap <silent> a_ :<C-U>call <SID>inner_underscore(1)<CR>

" ----------------------------------------------------------------------------
" ?ie | entire object
" ----------------------------------------------------------------------------
vnoremap <silent> ie gg0oG$
onoremap <silent> ie :<C-U>execute "normal! m`" <Bar> keepjumps normal! ggVG<CR>

" ----------------------------------------------------------------------------
" ?ic / ?iC | Blockwise column object
" ----------------------------------------------------------------------------
function! s:inner_blockwise_column(vmode, cmd)
  if a:vmode == "\<C-V>"
    let [pvb, pve] = [getpos("'<"), getpos("'>")]
    normal! `z
  endif

  execute "normal! \<C-V>".a:cmd."o\<C-C>"
  let [line, col] = [line('.'), col('.')]
  let [cb, ce]    = [col("'<"), col("'>")]
  let [mn, mx]    = [line, line]

  for pair in [[1, 'j'], [-1, 'k']]
    execute "normal! ".line."G".col."|"
    let [dir, mv] = pair
    while line('.') > 1 && line('.') < line('$')
      execute "normal! v".a:cmd."\<C-C>"
      if cb != col("'<") || ce != col("'>")
        break
      endif
      let [mn, mx] = [min([line('.'), mn]), max([line('.'), mx])]
      execute "normal! ".mv
    endwhile
  endfor

  execute printf("normal! %dG%d|\<C-V>%s%dG", mn, col, a:cmd, mx)

  if a:vmode == "\<C-V>"
    normal! o
    if pvb[1] < line('.') | execute "normal! ".pvb[1]."G" | endif
    if pvb[2] < col('.')  | execute "normal! ".pvb[2]."|" | endif
    normal! o
    if pve[1] > line('.') | execute "normal! ".pve[1]."G" | endif
    if pve[2] > col('.')  | execute "normal! ".pve[2]."|" | endif
  endif
endfunction

vnoremap <silent> ic mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'iw')<CR>
onoremap <silent> ic :<C-U>call   <SID>inner_blockwise_column('',           'iw')<CR>
vnoremap <silent> iC mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'iW')<CR>
onoremap <silent> iC :<C-U>call   <SID>inner_blockwise_column('',           'iW')<CR>


" ============================================================================
" PLUGINS
" ============================================================================

" ----------------------------------------------------------------------------
" vim-fugitive
" ----------------------------------------------------------------------------
nnoremap <Leader>g :Gstatus<CR>

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
let g:ctrlp_max_files  = 0
let g:ctrlp_max_height = 30
if s:ag
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
nnoremap <C-P><C-P> :CtrlPBuffer<cr>
nnoremap <C-P><C-T> :CtrlPBufTag<cr>

" ----------------------------------------------------------------------------
" ack.vim
" ----------------------------------------------------------------------------
if s:ag
  let g:ackprg = 'ag --nogroup --nocolor --column'
elseif !executable('ack')
  let g:ackprg = 'grep -rn "$*" * \| sed "s/:\([0-9]*\):/:\1:1:/" '
endif

" ----------------------------------------------------------------------------
" supertab
" ----------------------------------------------------------------------------
let g:SuperTabDefaultCompletionType = "<c-n>"
imap <tab> <Plug>SuperTabForward
imap <s-tab> <Plug>SuperTabBackward

" ----------------------------------------------------------------------------
" vim-copy-as-rtf
" ----------------------------------------------------------------------------
if s:darwin
  " Clipboard
  vnoremap <C-c> "*y

  " <C-V><C-V> Paste clipboard content
  inoremap <C-V><C-V> <c-o>"*P

  " Clipboard-RTF
  vnoremap <S-c> <esc>:colo seoul256-light<cr>gv:CopyRTF<cr>:colo seoul256<cr>
endif

" ----------------------------------------------------------------------------
" <Enter> | vim-easy-align
" ----------------------------------------------------------------------------
let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ '\': { 'pattern': '\\' },
\ '/': { 'pattern': '//\+\|/\*\|\*/', 'delimiter_align': 'l', 'ignore_groups': ['String'] },
\ '#': { 'pattern': '#\+',            'delimiter_align': 'l', 'ignore_groups': ['String'] },
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

" Legacy
" vnoremap <silent> <Enter> :EasyAlign<Enter>
" vnoremap <silent> <Leader><Enter> :LiveEasyAlign<Enter>

" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign with a Vim movement
nmap <Leader>a <Plug>(EasyAlign)

vmap <Leader><Enter>   <Plug>(LiveEasyAlign)
nmap <Leader><Leader>a <Plug>(LiveEasyAlign)

" inoremap <silent> => =><Esc>mzvip:EasyAlign/=>/<CR>`z$a<Space>

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
function! s:tmux_send(dest) range
  call inputsave()
  let dest = empty(a:dest) ? input('To which pane? ') : a:dest
  call inputrestore()
  silent call tbone#write_command(0, a:firstline, a:lastline, 1, dest)
endfunction
noremap <silent> <leader>t  :call <SID>tmux_send('')<cr>
noremap <silent> <leader>t1 :call <SID>tmux_send('.1')<cr>
noremap <silent> <leader>t2 :call <SID>tmux_send('.2')<cr>

" ----------------------------------------------------------------------------
" vim-indent-guides
" ----------------------------------------------------------------------------
" let g:indent_guides_enable_on_vim_startup = 1
" let g:indent_guides_guide_size            = 1
" let g:indent_guides_start_level           = 2

" ----------------------------------------------------------------------------
" vim-gitgutter
" ----------------------------------------------------------------------------
nmap gh <Plug>GitGutterNextHunk
nmap gph <Plug>GitGutterPrevHunk

silent! if emoji#available()
  let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
  let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
  let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
  let g:gitgutter_sign_modified_removed = emoji#for('collision')
endif

" ----------------------------------------------------------------------------
" vim-emoji :dog: :cat: :rabbit:!
" ----------------------------------------------------------------------------
function! s:replace_emojis() range
  for lnum in range(a:firstline, a:lastline)
    let line = getline(lnum)
    let subs = substitute(line,
          \ ':\([^:]\+\):', '\=emoji#for(submatch(1), submatch(0))', 'g')
    if line != subs
      call setline(lnum, subs)
    endif
  endfor
endfunction
command! -range ReplaceEmojis <line1>,<line2>call s:replace_emojis()

" ----------------------------------------------------------------------------
" vim-sneak
" ----------------------------------------------------------------------------
hi def link SneakPluginScope LineNr
hi def link SneakPluginTarget DiffChange
nmap s <Plug>Sneak_s
nmap S <Plug>Sneak_S

" ----------------------------------------------------------------------------
" goyo.vim
" ----------------------------------------------------------------------------
function! g:goyo_before()
  if has('gui_running')
    set fullscreen
    set background=light
    set linespace=7
  elseif exists('$TMUX')
    silent !tmux set status off
  endif
endfunction

function! g:goyo_after()
  if has('gui_running')
    set nofullscreen
    set background=dark
    set linespace=0
  elseif exists('$TMUX')
    silent !tmux set status on
  endif
endfunction

let g:goyo_callbacks = [function('g:goyo_before'), function('g:goyo_after')]

nnoremap <Leader>G :Goyo<CR>

" ----------------------------------------------------------------------------
" tcomment.vim
" ----------------------------------------------------------------------------
let g:tcommentTextObjectInlineComment = ''

" ----------------------------------------------------------------------------
" sideways.vim
" ----------------------------------------------------------------------------
nnoremap g< :SidewaysLeft<cr>
nnoremap g> :SidewaysRight<cr>
omap ia <Plug>SidewaysArgumentTextobjI
vmap ia <Plug>SidewaysArgumentTextobjI
omap aa <Plug>SidewaysArgumentTextobjA
vmap aa <Plug>SidewaysArgumentTextobjA

" ----------------------------------------------------------------------------
" undotree
" ----------------------------------------------------------------------------
let g:undotree_WindowLayout = 2
nnoremap U :UndotreeToggle<CR>


" ============================================================================
" AUTOCMD
" ============================================================================

augroup vimrc
  autocmd!

  au BufRead              *                   setlocal foldmethod=manual
  au BufRead              *                   setlocal nofoldenable
  au BufWritePost         .vimrc              source %

  au BufNewFile,BufRead   *.md                set filetype=markdown
  au BufNewFile,BufRead   *.icc               set filetype=cpp
  au BufNewFile,BufRead   *.pde               set filetype=java
  au BufNewFile,BufRead   *.less              set filetype=less
  au BufNewFile,BufRead   *.god               set filetype=ruby
  au BufNewFile,BufRead   *.coffee-processing set filetype=coffee

  au Filetype             slim                hi def link slimBegin NONE
  au Filetype,ColorScheme *                   call <SID>file_type_handler()

  if v:version >= 703
    au FileType clojure
    \ let vimclojure#ParenRainbow    = 1                      |
    \ let vimclojure#WantNailgun     = 1                      |
    \ let vimclojure#NailgunClient   = $HOME."/bin/ng"        |
    \ let vimclojure#SearchThreshold = 30                     |
    \ nmap <LocalLeader><LocalLeader> va)*``gv<LocalLeader>eb|
    \ vmap <LocalLeader><LocalLeader> <LocalLeader>eb|
    \ set isk+="-?"
  endif

  " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
  au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
  au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/
augroup END

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

" ----------------------------------------------------------------------------
" For screencasting with Keycastr
" ----------------------------------------------------------------------------
" map <tab> <nop>
" imap <tab> <nop>
" vmap <tab> <nop>

nmap fnr <Plug>(FNR%)
" Use the arrows to something usefull                                           
map <right> :bn<cr>                                                             
map <left> :bp<cr> 

""""""""""""""""""""""""""""""                                                  
" => MRU plugin                                                                 
""""""""""""""""""""""""""""""                                                  
let MRU_Max_Entries = 400                                                       
map <leader>f :MRU<CR>
" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>a :A!<cr>
nmap <leader>h :IH!<cr>

set fileencoding=utf-8
set fileencodings=utf-8,gb18030,ucs-bom,gbk,gb2312,cp936
set encoding=utf8

