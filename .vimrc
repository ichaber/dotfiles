" :help cmdline-completion | for more on autocompletion
" :setfiletype + Ctrl-d | to see all available filetypes
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
" Set regex engine to 2 to avoid infinite loops with syntax on in TS
set re=2

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
autocmd FileType php setlocal shiftwidth=4 tabstop=4
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType json setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType cs setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType rust setlocal expandtab shiftwidth=4 softtabstop=4

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

" Open terminal on the right with Alt+F12 (detach with Ctrl+D 
nnoremap <A-F12> :wa \| vertical botright term ++kill=term<CR>

" Remap buffers F5
nnoremap <F5> :buffers<CR>:buffer<Space>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Configure AutoComplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap tab to trigger autocomplete
inoremap <expr> <Tab> pumvisible() ? '<C-n>' :
\ getline('.')[col('.')-2] =~# '[[:alnum:].-_#$]' ? '<C-x><C-o>' : '<Tab>'
" Allows to keep typing on autocomplete and select the next match
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

if has('patch-8.1.1880')
  set completeopt=longest,menuone,popuphidden
  " Highlight the completion documentation popup background/foreground the same as
  " the completion menu itself, for better readability with highlighted
  " documentation.
  set completepopup=highlight:Pmenu,border:off
else
  set completeopt=longest,menuone,preview
  " Set desired preview window height for viewing documentation.
  set previewheight=5
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Autoinstall vim-plug if it doesn't exist
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

filetype off                  " required

"Start plugin config using vim-plug
call plug#begin()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree + config
Plug 'scrooloose/nerdtree'
"F6 toggles NerdTree
nmap <F6> :NERDTreeToggle<CR>
"close vim with NerdTree as the last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"Open NERDTree automatically if no file is selected
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"Prevent NerdTree toggle from resizing multiple windows
autocmd VimEnter * set winfixwidth

"
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Airline plugin + config
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Airline theme
let g:airline_theme='jellybeans'
"Smarter tab line
let g:airline#extensions#tabline#enabled = 1
"Show buffers within a single tab
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tab_type = 1
"Improve Contrast
let g:airline_base16_improved_contrast = 1
"Use powerline symbols from font
let g:airline_powerline_fonts = 1
"Show git branch
let g:airline#extensions#branch#enabled=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plug 'dense-analysis/ale'
let g:airline#extensions#ale#enabled = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'OmniSharp/omnisharp-vim'
"Tell Ale to use Omnisharp as linter
let g:ale_linters = { 'cs': ['OmniSharp'] }
let g:OmniSharp_server_use_net6 = 1
let g:OmniSharp_highlight_types = 2
let g:OmniSharp_selector_ui = 'fzf'    " Use fzf for autocomplete
let g:OmniSharp_selector_findusages = 'fzf' " Use fzf as a selector
nnoremap <C-o><C-u> :OmniSharpFindUsages<CR>
nnoremap <C-o><C-d> :OmniSharpGotoDefinition<CR>
nnoremap <C-o><C-d><C-p> :OmniSharpPreviewDefinition<CR>
nnoremap <C-o><C-r> :!dotnet run
autocmd CompleteDone * pclose

let g:OmniSharp_popup_options = {
\ 'highlight': 'Normal',
\ 'padding': [1],
\ 'border': [1]
\}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Deprecated Syntastic
"Syntastic + config
"Add Syntastic plugin here "
"Plugin 'vim-syntastic/syntastic'
"let g:airline#extensions#syntastic#enabled = 1

"let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
"let g:syntastic_always_populate_loc_list = 1
"Show summary list of errors at the bottom
""let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Install fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup code completion using release branch (recommended)
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"let g:coc_disable_startup_warning = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" All of your Plugins must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PlugStatus                        - Check the status of plugins
" :PlugInstall [name ...] [#threads] - Install plugins
" :PlugUpdate [name ...] [#threads]  - Install or update plugins
" :PlugClean[!]	                     - Remove unlisted plugins (bang version will clean without prompt)
" :PlugUpgrade                       - Upgrade vim-plug itself
" :PlugDiff                          - Examine changes from the previous update and the pending changes
" :PlugSnapshot[!] [output path]     - Generate script for restoring the current snapshot of the plugins
"
" see :h plug for general help
" Put your non-Plugin stuff after this line
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => END Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! WordProcessorMode()
 setlocal textwidth=80
 setlocal smartindent
 setlocal spell spelllang=en_us
 setlocal noexpandtab
endfu

com! WP call WordProcessorMode()

func! NoWordProcessorMode()
 setlocal spell nospell
endfu

com! NWP call NoWordProcessorMode()

func! CopyTextMode()
 setlocal nonu
 setlocal nornu
endfu

com! CTM call CopyTextMode()

func! NoCopyTextMode()
 setlocal nu
 setlocal rnu
endfu
com! NCTM call NoCopyTextMode()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => End Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Experimental
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search down into subfolders
" Provides tab-completion for all file-related tasks (performance on big
" subtrees)
" set path +=**
" Display all matching files when we tab complete
set wildmenu
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoVIM only features in .vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !has('nvim')
" Neovim only features go here
endif
