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
nnoremap <silent> <leader>m :Marks<CR>
nnoremap <silent> <C-p> :History<CR>
nnoremap <silent> <C-h> :History:<CR>

" search a word (under cursor) withing current directory
nnoremap <silent> <leader>/ :Rg <C-r>=expand('<cword>')<CR><CR>
" search selected text within current directory
vnoremap // y:Rg <C-R>=escape(@",'/\')<CR><CR>

nnoremap <leader>f :NERDTreeToggle %<Enter>
imap jj <Esc>

nnoremap <leader>F :Files<Enter>

" Print full path
map <C-f> :echo expand("%:p")<cr>

" Use Tab to swich the window
" forward
map <Tab> <C-w>w
" backward (shift+tab)
map <S-Tab> <C-w>W

set number relativenumber

set hidden
set confirm

set tabstop=4
set noexpandtab
set shiftwidth=4
set encoding=UTF-8

" disable bell sounds
set noerrorbells
set vb t_vb=

highlight Normal ctermbg=black ctermfg=white
set background=dark

let g:gruvbox_italic = 1
colorscheme gruvbox

" to make background invisible
hi Normal ctermbg=NONE guibg=NONE

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

" Next commands make vim use X11 clipboard
set clipboard=unnamed
" x clipboard
vnoremap y "*y
noremap p "*p
" system clipboard
vnoremap Y "+y
noremap P "+p

" set tab symbol visible
set list

" set vertical cursor position highlighting
set cursorcolumn

" remove trailing whitespace on writing
autocmd BufWritePre * %s/\s\+$//e
