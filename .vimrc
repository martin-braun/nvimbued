" This file is not part of your local nvim setup.
" However, it is meant to be uploaded to remote systems
" to let vim behave more like your local nvim setup.
" Local install: `cp .vimrc $HOME/`
" Remote install: `scp .vimrc <alias>:.`
set clipboard^=unnamed,unnamedplus
set number
set relativenumber
set nocompatible
filetype on
syntax on
colorscheme habamax
set cursorline
let mapleader = " "
let g:netrw_banner = 0
nnoremap <C-b> <CMD>terminal<CR> " only works when not in a tmux session
tnoremap <Esc> <C-\\><C-n>
nnoremap <leader>b <CMD>ls<CR>
nnoremap <leader>c <CMD>ene<CR>
nnoremap <leader>e :e 
nnoremap <leader>yf <CMD>let @+=expand("%")<CR>
nnoremap <leader>yF <CMD>let @+=expand("%:p")<CR>
nnoremap <leader>x <CMD>bd<CR>
nnoremap <leader>X <CMD>bd!<CR>
nnoremap <leader>ff gg=G''
nnoremap <leader>tt <CMD>terminal<CR>a
nnoremap <leader>ts <CMD>split<CR><CMD>wincmd j<CR><CMD>terminal<CR>a
nnoremap <leader>tv <CMD>vsplit<CR><CMD>wincmd l<CR><CMD>terminal<CR>a
nnoremap <C-s> <CMD>w<CR>
nnoremap <leader>ss <CMD>wa<CR>
nnoremap <leader>L <CMD>set nonumber! norelativenumber!<CR>
nnoremap <leader>R <CMD>checktime<CR>
nnoremap <C-w>s <CMD>split<CR><CMD>wincmd j<CR>
nnoremap <C-w>v <CMD>vsplit<CR><CMD>wincmd l<CR>
nnoremap <C-e> <CMD>Ex %:p:h<CR>
nnoremap <C-n> <CMD>tabnew<CR>
nnoremap <C-j> <CMD>tabn<CR>
nnoremap <C-k> <CMD>tabp<CR>
nnoremap <C-q> <CMD>tabc<CR>
autocmd FileType netrw nnoremap <buffer> <C-e> <CMD>Rex<CR>
command! Inspect :echo synIDattr(synID(line("."),col("."),1),"name")

