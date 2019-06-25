" exit and save
:imap <special> ZZ <Esc>:wq!<Return>
" exit and no save
:imap <special> QQ <Esc>:q!<Return>
:map <special> QQ :q!<Return>
:map Q <Nop>
" add line relative to cur line
:imap <special> <Bar><Bar> <Esc>O
:imap <special> \\ <Esc>o
" move around line
:imap <special> << <Esc>^i
:imap <special> >> <Esc>$a
nnoremap B ^
nnoremap E $
nnoremap << ^i
nnoremap >> $a
:imap <special> %% <Esc>%i
" incr/dec tab level
nnoremap <Tab> >
nnoremap <S-Tab> <

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

