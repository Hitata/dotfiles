local keymap = vim.keymap

keymap.set("n", "<leader>sv", ":luafile $VIMRC<CR>")

keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>nh", ":nohl<CR>")

keymap.set("n", "<leader>n", ":NvimTreeFindFile<CR>")

keymap.set('n', 'x', '"_x')

