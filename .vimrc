set smartindent
set cindent
set nobackup
set nu

if has("syntax")
	syntax on
endif

map ^[[6~ ^D
map ^[[5~ ^U

map ^[[B ^E
map ^[[A ^Y

function! Nunu()
    if &nu
        set nonu
    else
        set nu
    endif
endfunction

let g:explVertical=1
let g:explWinSize=20

" set auto indent
set autoindent

" always show a status line
set laststatus=2

" show (partial) command in status line
set showcmd

" use visual bell instead of beeping
set visualbell

" don't redraw screen while exectuing macros
set lazyredraw

" allow backspace to erase over start of insert, autoindent, and eol
set backspace=2

" I mostly use dark backgrounds
set background=dark

" set timeout to 0.5 s.
set timeoutlen=500

" wrap cursor when using <bs> or <space>
set whichwrap=b,s

" avoid annoying "Hit ENTER to continue" prompts and intro-screen
set shortmess=aI

" hilight searches
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

" count a tab as 4 spaces
set tabstop=2

" use 4 tabs when indenting
set shiftwidth=2

set expandtab

" restore visual selction after indenting
:vnoremap < <gv
:vnoremap > >gv

" use filetype plugins and indenting
filetype plugin on
filetype indent on

" display full path to file, filetype and buffer number in statusline
set statusline=%<[%n]\ %F\ %m%r%y%=%-14.(%l,%c%V%)\ %P

" remember marks for 20 files, max 50 lines pr reg., dont hilight last search
" set viminfo='20,<50,h

" use modlines
set modeline

" always show two lines above and below cursor
set scrolloff=3

" Dont list hidden files when using explorer.vim
let g:explHideFiles='^\.'

" Dont list hidden files when using netrw
let g:netrw_list_hide='^\.,~$'

" Make TOhtml use CSS and XHTML
let html_use_css=1
let use_xhtml=1

" show possible matches above the command line when using tab completion
set wildmenu

" Korean Language Setting
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,euc-kr,latin1

" ctags
" set tags=./tags,../tags,../../tags,../../../tags,../../../../tags

set tags=./tags;/
" cscope -- not needed. we have this in 
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dictionary
" nmap <C-\>k :!edic.rb <C-R>=expand("<cword>")<CR><CR>
" nmap <C-\>K :!eedic.rb <C-R>=expand("<cword>")<CR><CR>

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
inoremap <F5> <esc>:call RunThisScript()<cr>
noremap <F5> :call RunThisScript()<cr>

" Under line
inoremap <F6> <esc>yyp:s/[^\t]/=/g<cr>:nohl<cr>a
noremap <F6> yyp:s/[^\t]/=/g<cr>:nohl<cr>
"noremap <S-F7> yyP:s/[^\t]/=/g<cr>:nohl<cr>

" Save
inoremap <C-s> <esc>:w<cr>a
noremap <C-s> :w<cr>

" Quit
inoremap <F10> <esc>:q<cr>
noremap <F10> :q<cr>
inoremap <C-Q> <esc>:q<cr>
noremap <C-Q> :q<cr>

" Toggle line number display
inoremap <F12> <esc>:call Nunu()<cr>:f<cr>a
noremap <F12> :call Nunu()<cr>:f<cr>

"noremap <F12> :call Nunu()<cr>

" NERD Tree
"inoremap <F11> <esc>:exe "cd " . fnamemodify(expand('%'), ":p:h")<cr>:NERDTree<cr>
"noremap <F11> :exe "cd " . fnamemodify(expand('%'), ":p:h")<cr>:NERDTree<cr>
inoremap <F11> <esc>:NERDTree<cr>
noremap <F11> :NERDTree<cr>

set pastetoggle=<Ins>
set pastetoggle=<F9> " For Mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Multi-window toggle
" function ToggleWindow()
" 	execute "normal \<C-W>\<C-W>"
"  	if expand('%') == '-MiniBufExplorer-'
" 		execute "normal \<C-W>\<C-W>"
" 	endif
" 	echo fnamemodify(expand('%'), ":p")
" endfunction
" map <tab> :call ToggleWindow()<cr>
" 
" " Doesn't work correctly if window has no target file
" function ToMiniBuf()
" 	let initial = expand('%')
" 	while 1 
" 		execute "normal \<C-W>\<C-W>"
" 		if expand('%') == initial || expand('%') == '-MiniBufExplorer-'
" 			break
" 		endif
" 	endwhile
" 	echo fnamemodify(expand('%'), ":p")
" endfunction
" map <S-tab> :call ToMiniBuf()<cr>
	
" function FuzzyFinder()
" 	let initial = expand('%')
" 	while 1 
" 		execute "normal \<C-W>\<C-W>"
" 		if expand('%') == initial || (expand('%') != '-MiniBufExplorer-' && match(expand('%'), 'NERD_tree_.*'))
" 			break
" 		endif
" 	endwhile
" 	exe('FufFile **/')
" endfunction
" " Fuzzy Finder
" inoremap <F7> <esc>:call FuzzyFinder()<cr>
" noremap <F7> :call FuzzyFinder()<cr>
"
" " Minibufexplorer
" let g:miniBufExplMapWindowNavArrows = 1 
" let g:miniBufExplMapWindowNavVim = 1 
" " let g:miniBufExplMapCTabSwitchBufs = 1 
" let g:miniBufExplModSelTarget = 1 
" " let g:miniBufExplTabWrap = 1
" " let g:miniBufExplModSelTarget = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <tab> <C-W><C-W>
map <S-tab> :FufBuffer<cr>
inoremap <F7> <esc>:FufFile **/<cr>
noremap <F7> :FufFile **/<cr>

" Color setting
"colo brown
"colo relaxedgreen
"colo black_angus
"colo darkdot
"colo slate
"set t_Co=256
colo automation
"hi LineNr ctermfg=magenta
hi Search term=reverse ctermbg=blue ctermfg=white
hi StatusLine ctermfg=6

" For syntax highlighting and snipMate
au BufRead,BufNewFile *.icc set filetype=cpp
au BufRead,BufNewFile *.pde set filetype=java
"au BufRead,BufNewFile *.html.erb set filetype=html.eruby

" Escaping!
map! jk <esc>
vmap jk <esc>

" For MacVim
set noimd
set imi=1
set ims=-1

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

" dbext (not sure about this)
" let g:dbext_default_profile_mysql_local = 'type=MYSQL:user=root:passwd=:dbname=test:extra=-t'
" let g:dbext_default_profile_oracle = 'type=ORA:srvname=//10.10.99.206\:1600/datahub:user=datahub:passwd=datahubdb'
" let g:dbext_default_buffer_lines = 15
" let g:dbext_default_profile = 'oracle'
" -- ,s(ql)e(xecute)
" -- ,s(ql)t(able)
" -- ,s(ql)d(escribe)t(able)
" -- ,s(ql)d(escribe)p(rocedure)
" -- ,s(ql)l(ist)t(able)
" -- ,s(ql)l(ist)c(olumn)
" -- dbext:profile=oracle

" Capistrano
au BufNewFile,BufRead capfile	setf ruby
au BufNewFile,BufRead Capfile	setf ruby

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

" Yank lines
" inoremap <C-y> <C-o>yy

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
vmap <C-k> xkP`[V`]
vmap <C-j> xp`[V`]

" Indentation
vmap <C-h> <
vmap <C-l> >

" Tabular.vim
vmap <C-T>: :Tab /:<CR>
vmap <C-T>:: :Tab /:\zs<CR>
vmap <C-T>= :Tab /=<CR>
vmap <C-T>== :Tab /[- +*/]\{,1}=<CR>
vmap <C-T>=> :Tab /=><CR>
let g:tabular_default_format = "l1-1"

" Auto-reload .vimrc
au! BufWritePost .vimrc source %

" Replace (wow)
vmap R "_dP
" vmap R :call feedkeys( line('$')==line('.') ? "_dp : "_dP )<CR>

let vimclojure#ParenRainbow = 1
