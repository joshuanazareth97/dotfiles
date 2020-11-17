"  ██╗███╗   ██╗███████╗ ██████╗ ██╗     ██╗   ██╗██╗███╗   ███╗
" ██╔╝████╗  ██║██╔════╝██╔═══██╗╚██╗    ██║   ██║██║████╗ ████║
" ██║ ██╔██╗ ██║█████╗  ██║   ██║ ██║    ██║   ██║██║██╔████╔██║
" ██║ ██║╚██╗██║██╔══╝  ██║   ██║ ██║    ╚██╗ ██╔╝██║██║╚██╔╝██║
" ╚██╗██║ ╚████║███████╗╚██████╔╝██╔╝     ╚████╔╝ ██║██║ ╚═╝ ██║
"  ╚═╝╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝       ╚═══╝  ╚═╝╚═╝     ╚═╝


" ====== General Options ====== 

" Remap leader
let mapleader="\<Space>"

" Hide abandoned buffers instead of closing
set hidden

" Finding files (:find), search down into subfolders, tab-completion
set path+=**

" Ignore case when searching unless upper case is used
set ignorecase
set smartcase

" Show line number relative to current line. Current line shows absolute
" number
set number
set relativenumber

" Set number of lines visible above/below the cursor when possible
set scrolloff=5

" Mouse support
set mouse=a

" use undodir for persistent undoing across file closure
set undodir=~/.vim/undodir
set undofile

" copy indent from current line when starting a new line
set autoindent

" expand tabs to spaces
set expandtab


" ====== Keyboard Shortcuts ======

" F9 to toggle paste mode
nnoremap <silent><F9> :set paste!<CR>


" ====== Plugins ======

" Install plug if not present
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' } " Color Scheme
Plug 'itchyny/lightline.vim' " Status bar
Plug 'sheerun/vim-polyglot' " Better syntax highlighting
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Code completion, linting and more
Plug 'tpope/vim-fugitive' " Best Git wrapper of all time
Plug 'scrooloose/nerdtree' " File Tree
Plug 'ryanoasis/vim-devicons' " Icons based on filetype

call plug#end()

" COC Settings
set cmdheight=2
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()


" ====== Python Env Config ======

let g:python3_host_prog = '$WORKON_HOME/py3nvim/bin/python'
" NOTE: Alse see coc-settings.json for linting, autocomplete etc.


" ====== Web Env Config ======


" ====== Appearance ======

set t_Co=256

" Main Vim Colorscheme
syntax on
colorscheme dracula

" Lightline Appearance
        " Colorscheme
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ 
\}

        " Separators
let g:lightline.separator = {
	\   'left': '', 'right': ''
  \}

let g:lightline.subseparator = {
	\   'left': '', 'right': ''
  \}

let g:lightline.active = {
      \   'left': [ ['mode', 'paste', 'gitbranch' ],
      \             [ 'readonly', 'modified' ] ]
      \}

function! BranchWithPrefix() 
  let l:git_status = fugitive#head()
  if (l:git_status=='')
          return ''
  endif 
  return " ".git_status
endfunction

let g:lightline.component_function = {
        \ 'gitbranch' : 'BranchWithPrefix'
      \}


" Dont show insert indicator, handled by statusline
 set noshowmode

" Column for lint errors, etc
set signcolumn=yes

" Highlight all search pattern matches
set hlsearch
