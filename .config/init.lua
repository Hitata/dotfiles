" Plugins
call plug#begin("~/.vim/plugged")
Plug 'ryanoasis/vim-devicons'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'

" LSP Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
" Plug 'nvim-lua/completion-nvim'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'pangloss/vim-javascript'
" Plug 'HerringtonDarkholme/yats.vim'
Plug 'leafgarland/typescript-vim'

Plug 'maxmellon/vim-jsx-pretty'
" Plug 'peitalin/vim-jsx-typescript'

Plug 'tomasiser/vim-code-dark'

call plug#end()

colorscheme codedark 

set scrolloff=8
set number
set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set fileencodings=utf-8,jis,euc-jp,latin
set encoding=utf-8
let g:airline_powerline_fonts = 1

" open new split panes to right and below
set splitright
set splitbelow

if (has("termguicolors"))
set termguicolors
endif
syntax enable

let mapleader = ","
nnoremap <leader>pv :Vex<CR>
nnoremap <leader>pf :Files<CR>
inoremap jk <esc>:w<CR>
nnoremap <C-p> :GFiles<CR>

" edit & source vimrc
nnoremap <leader>cv :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" copy to clipboard
nnoremap Y "+y
vnoremap Y "+y
nnoremap yY ^"+y$

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 0
let g:NERDTreeIgnore = ['node_modules']
let NERDTreeStatusLine='NERDTree'
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-a> :NERDTreeToggle<CR>
nnoremap <leader> n :NERDTreeFocus<CR>

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
split term://zsh
resize 15
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

let g:prettier#autoformat_config_present = 1
let g:prettier#config#config_precedence = 'prefer-file'

let g:vim_jsx_pretty_highlight_close_tag = 1
let g:vim_jsx_pretty_colorful_config = 1

" LSP
lua << EOF
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- mappings
  local opts = { noremap=true, silent=true }

  -- keymapping
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

local saga = require 'lspsaga'

saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
}

EOF

nnoremap <silent> <C-j> <Cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent>K <Cmd>Lspsaga hover_doc<CR>
inoremap <silent> <C-k> <Cmd>Lspsaga signature_help<CR>
nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>

