source $VIMRUNTIME/mswin.vim
behave mswin

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles
Bundle 'klen/python-mode'
Bundle 'Valloric/YouCompleteMe'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rake'
Bundle 'nanotech/jellybeans.vim'
" Bundle 'Lokaltog/powerline'
" Here is a good replacement for powerline
" Bundle 'bling/vim-airline'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
" Bundle 'scrooloose/nerdcommenter'
Bundle 'kien/ctrlp.vim'
Bundle 'rking/ag.vim'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'slim-template/vim-slim'
Bundle 'skammer/vim-css-color'

syntax on
filetype plugin indent on

""""""""""""""""""""""""""""""""""
" The rest of configs            "
""""""""""""""""""""""""""""""""""

set encoding=utf-8
"set fillchars+=stl:\ ,stlnc:\
syntax enable

" Set spell checking for english 
set spell

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" Always show current position 
set ruler 

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" " Fast saving
" nmap <leader>w :w!<cr>

" Use <leader>l to toggle display of whitespace
nmap <leader>l :set list!<CR>

" And set some nice chars to do it with
set listchars=tab:»\ ,eol:¬

" automatically change window's cwd to file's dir
set autochdir

" I'm prefer spaces to tabs
set tabstop=4
set shiftwidth=4
set expandtab

" Remove empty space at the bottom of gVim
set guiheadroom=0

" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc


" Set to auto read when a file is changed from the outside
set autoread

" more subtle popup colors
"if has ('gui_running')
"	highlight Pmenu guibg=#cccccc gui=bold
"endif


" make sure to enable 256 colors
" set t_Co=256

" set background=dark
colo molokai

let g:molokai_original = 1
let g:rehash256 = 1

" CSS Color
let g:cssColorVimDoNotMessMyUpdatetime = 1
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" set cursorline
set nowrap
set expandtab

set ignorecase
set smartcase

set number
set autoindent
set smartindent

set backup
set history=100
set undolevels=100
" set term=xterm-256color


" Powerline setup
set guifont=Monofur\ for\ Powerline\ 14
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2
set noshowmode

" NERDTree, toggle the tree view with F2
map <F2> :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['\.pyc$']

" backup path
if filewritable(expand("~/.vim/backup")) == 2
		set backupdir=$HOME/.vim/backup
else
	if has("unix") || has("win32unix")
			call system("mkdir $HOME/.vim/backup -p")
			set backupdir=$HOME/.vim/backup
	endif
endif


" Restriction to line width for python files
augroup vimrc_autocmds
	autocmd!
	" highlight characters past column 120
	autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
	autocmd FileType python match Excess /\%120v.*/
	autocmd FileType python set nowrap
augroup END

" Quit with :Q
" command -nargs=0 Quit :qa!


" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator
" modes)
" " ]]            Jump on next class or function (normal, visual, operator
" modes)
" " [M            Jump on previous class or method (normal, visual, operator
" modes)
" " ]M            Jump on next class or method (normal, visual, operator
" modes)
let g:pymode_rope = 0
let g:pymode_rope_enable_autoimport = 1

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
"let g:pymode_lint_write = 1

" Run linter on the fly
let g:pympde_lint_onfly = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0


" Show text limit line
if (v:version >=703)
    set colorcolumn=100
    hi ColorColumn ctermbg=red ctermfg=white guibg=#592929
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif
                 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile



" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
" Remember info about open buffers on close
set viminfo^=%

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

