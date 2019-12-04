set nocompatible
syntax on
set nowrap
set encoding=utf8

set number
set ruler

set list lcs=trail:·,tab:»·
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab

set cursorline

colorscheme gruvbox
set t_Co=256
set background=dark


" NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
