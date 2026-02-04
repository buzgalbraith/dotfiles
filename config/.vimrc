set nocompatible

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

"relative line numbering
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" unmap arrow keys
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>
" easy motion set up 
nmap <Leader>/ <Plug>(easymotion-sn)
xmap <Leader>/ <Plug>(easymotion-sn)
omap <Leader>/ <Plug>(easymotion-tn)
" map control y and control C to copy to buffer
vnoremap <C-C> "+y
vnoremap <C-y> "+y

" setting for vim-commentary plugin that is used for commenting multiple lines at once
filetype plugin indent on

"adding some keyboard shortcuts for nerd tree  
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

"keybindings for fuzzy file finder, control p searches the current dir leader
"p lets you enter a path to search
nnoremap <C-p> :CtrlP<CR>
nnoremap <leader>p :execute 'CtrlP ' . input('CtrlP directory: ', '', 'dir')<CR>

"ale setup 
let g:ale_linters = {
\   'python': ['ruff', 'mypy']
\}
let g:ale_fixers = {
\   'python': ['ruff', 'ruff_format']
\}
"" these are installed in `scripts/vim_setup.sh` 
let g:ale_python_mypy_executable = $HOME."/.base_env/bin/mypy"
let g:ale_python_pylint_executable = $HOME.'/.base_env/bin/pylint'
let g:ale_python_ruff_executable = $HOME.'/.base_env/bin/ruff'

let g:ale_python_ruff_options = '--select E,W,F,I,UP,ANN'
" setting color theme 
set background=light
colorscheme rosepine

" setting it so cursor shows the column 
set cursorcolumn

" jedi vim switch how new code is pulled up
let g:jedi#use_splits_not_buffers = "right"
" have control p and nerd tree show hidden files
let g:ctrlp_show_hidden = 1
let NERDTreeShowHidden=1
" keyboard shortcut for vim ack 
nnoremap <leader>a :Ack<space>

"fix vormating issues when pasting from buffer while tmux is active
if &term =~ '^tmux'
	let &t_BE="\<Esc>[?2004h"
	let &t_BD="\<Esc>[?2004l"
	let &t_PS="\<Esc>[200~"
	let &t_PE="\<Esc>[201~"
endif

"" adding spell check for US english
let g:asyncomplete_auto_popup = 0
let g:asyncomplete_sources = ['spell']
set spell
set spelllang=en_us
nnoremap <leader>. z=
"" need to set typos to be in a certain color so they work with the theme 
highlight SpellBad term=underline cterm=underline ctermfg=Red gui=undercurl guisp=Red
"" keyboard shortcuts for splits
nnoremap <leader>sh :split<CR>
nnoremap <leader>sv :vsplit<CR>
"" keyboard shortcuts for buffers 
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
""merge the current and previous buffer into one vertically
nnoremap <Leader>sb :vert sb #<CR> 
"" paste on a new line by default
nnoremap P O<Esc>p

"" show 5 lines above or bellow cursor if possible
set scrolloff=5 
