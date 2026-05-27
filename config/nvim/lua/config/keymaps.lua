-- this holds core vim keymaps, note that some specfic plugins may have keymaps listed in their lua file in ../plugins/ 

-- set leader must be done before loading plug ins
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- short cut for making vim panes
vim.keymap.set("n", "<Leader>sv", '<cmd>vsplit<CR>')
-- vim.keymap.del("n", "<Leader>sh")
vim.keymap.set("n", "<Leader>sh", '<cmd>split<CR>')

