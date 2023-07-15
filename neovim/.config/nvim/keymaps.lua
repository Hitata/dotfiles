vim.g.mapleader = ","

local keymap = vim.keymap

-- keymap.set('n', '<leader>sv', ':source $VIMRC')

keymap.set("n", "<leader>sv<CR>", ":luafile $VIMRC<CR>")
