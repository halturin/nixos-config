let NERDTreeQuitOnOpen = 1
let mapleader = ","

" Some useful quickfix shortcuts for quickfix
map <C-n> :cn<CR>
map <C-m> :cp<CR>
nnoremap <leader>a :cclose<CR>

" Enter automatically into the files directory
" autocmd BufEnter * silent! lcd %:p:h

" Fast saving
nnoremap <leader>w :w!<cr>
nnoremap <silent> <leader>q :q!<CR>

nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <leader>O :Files!<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <C-p> :History<CR>

nnoremap <leader>f :NERDTreeToggle<Enter>
imap jj <Esc>

nnoremap <leader>F :Files<Enter>

" Print full path
map <C-f> :echo expand("%:p")<cr>

set number relativenumber

set hidden
set confirm

set tabstop=4
set expandtab
set shiftwidth=4
set encoding=UTF-8

" disable bell sounds
set noerrorbells
set vb t_vb=

highlight Normal ctermbg=black ctermfg=white
set background=dark

let g:gruvbox_italic = 1
colorscheme gruvbox
" Airline powerline fonts fix
let g:airline_powerline_fonts = 1
" Airline theme
let g:airline_theme = 'gruvbox'

set mouse=a


" vim-go settings
nmap <C-g> :GoDecls<cr>
imap <C-g> <esc>:<C-u>GoDecls<cr>


set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

set cursorline
set nohlsearch
