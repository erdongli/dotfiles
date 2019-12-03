set nocompatible                      " disable compatible mode

set tabstop=2                         " tab width
set shiftwidth=2                      " indent width
set list                              " visiblize tabs
set listchars=tab:.\ ,trail:.         " tab => spaces set list
set expandtab

set number                            " show line number
set ruler                             " show cursor status
set cursorline                        " highlight current line
set showcmd                           " show commands
set showmatch                         " match parentheses

set clipboard+=unnamed

set backspace=indent,eol,start

set background=dark
colorscheme gruvbox

filetype plugin indent on
syntax on

" protobuf
augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

" plugins

" nerdtree
autocmd VimEnter * NERDTree | wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" tagbar
autocmd VimEnter * nested :TagbarOpen | wincmd p
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" vim-go
let g:go_fmt_autosave = 1             " disable autoformat
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

let g:go_template_autocreate = 0

let g:go_list_height = 30
