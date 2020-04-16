set encoding=utf-8

" Add a 80 character marker
set colorcolumn=80

" Display tabs as 8 spaces
set tabstop=8

" Expand tab presses to 4 spaces
set softtabstop=0 expandtab shiftwidth=4 smarttab

autocmd FileType conf setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType css setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType php setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType js setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType go setlocal shiftwidth=8 softtabstop=0 noexpandtab

" Show line numbers
set number

colorscheme gruvbox
