
source ~/.shell/nvim/plugins.vim
"source ~/.shell/nvim/rust1.vim
source ~/.shell/nvim/commands.vim 

set mouse=a
set encoding=utf-8
set number
set noswapfile

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix

let NERDTreeShowHidden = 1

if ($OS == 'Windows_NT')
    set shell=powershell
endif

syntax enable
colorscheme edge

if (has('termguicolors'))
  set termguicolors
endif

"## Auto saving when leaving insert mode
autocmd InsertLeave * silent! update

" Use a faster updatetime so vim-gutter reflects changes faster, as well as
" whatever LSP plugin we're using
set updatetime=250
