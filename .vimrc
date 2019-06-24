:imap <special> ZZ <Esc>:wq!<Return>
:imap <special> QQ <Esc>:q!<Return>
:imap <special> >> <Esc>$i
:imap <special> << <Esc>^i
:imap <special> $$ <Esc>$i
:imap <special> ^^ <Esc>^i
nnoremap B ^
nnoremap E $
nnoremap > e
nnoremap < b
nnoremap >> $
nnoremap << ^

filetype plugin indent on
set showmatch
syntax enable
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" line numbering
set nu
" utility
set wildmenu

" search
set incsearch
set hlsearch

" colorscheme

