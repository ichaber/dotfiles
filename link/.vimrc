" be iMproved, required
set nocompatible

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Show line numbers
set nu
"Relative line numbers
set relativenumber
"Enable syntax highlight
syntax on
"Always show current position
set ruler
" Set to auto read when a file is changed from the outside
set autoread
" When searching try to be smart about cases 
set smartcase
" Highlight search results
set hlsearch
" Show incremental search results as you type
set incsearch
" Show matching brackets when text indicator is over them
set showmatch
" For regular expressions turn magic on
set magic 
" Set scroll to show 1 line above or below current scroll position
set scrolloff=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
"set nobackup
"set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Replace tabs with spaces "
set expandtab
" Be smart when using tabs ;)
set smarttab

autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType json setlocal expandtab shiftwidth=4 softtabstop=4

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key maping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","

" Edit vimr configuration file
nnoremap <Leader>ve :e $MYVIMRC<CR>
" Reload vims configuration file
nnoremap <Leader>vr :source $MYVIMRC<CR>

" Remap navigation for splits to only C-x
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree + config
Plugin 'scrooloose/nerdtree'
"F6 toggles NerdTree
nmap <F6> :NERDTreeToggle<CR>
"close vim with NerdTree as the last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"Open NERDTree automatically if no file is selected
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Airline plugin + config
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Airline theme
let g:airline_theme='jellybeans'
"Smarter tab line
let g:airline#extensions#tabline#enabled = 1
"Improve Contrast
let g:airline_base16_improved_contrast = 1
"Use powerline symbols from font
let g:airline_powerline_fonts = 1
"Show git branch
let g:airline#extensions#branch#enabled=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Syntastic + config
"Add Syntastic plugin here "
Plugin 'vim-syntastic/syntastic'
let g:airline#extensions#syntastic#enabled = 1

"let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
"let g:syntastic_always_populate_loc_list = 1
"Show summary list of errors at the bottom
""let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Experimental
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search down into subfolders
" Provides tab-completion for all file-related tasks (performance on big
" subtrees)
" set path +=**
" Display all matching files when we tab complete
set wildmenu
