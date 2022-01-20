let mapleader = ","

nnoremap <leader>pv :Vex<CR>
inoremap jk <esc>:w<CR>
" 
nnoremap <leader>pf :Files<CR>
nnoremap <C-f> :Files<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>f :Rg<CR>

" edit & source vimrc
nnoremap <leader>cv :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" copy to clipboard
nnoremap Y "+y
vnoremap Y "+y
nnoremap yY ^"+y$


