-- set leader must be done before loading plug ins
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
-- load plugins
require('config.lazy')
-- other core settings bellow
-- set base color scheme
vim.cmd.colorscheme 'habamax'
-- line numbering 
vim.o.number = true
-- relative line numbering
vim.o.relativenumber = true
-- enable mouse mode
vim.o.mouse = 'a'
-- yank to system keyboard see `:help clipboard` 
-- the schedule thing is a slight optimization from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
-- smart indentation see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim
vim.o.breakindent  = true
-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true
-- This setting makes search case-insensitive when all characters in the string
--  being searched are lowercase. However, the search becomes case-sensitive if
-- it contains any capital letters. This makes searching more convenient.
-- V
vim.o.ignorecase = true
vim.o.smartcase = true
-- keep warning buffer (ie single column) present at all times
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 800
-- make at least 10 lines shown above or bellow if possible
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')


-- short cut for making vim panes
vim.keymap.set("n", "<Leader>sv", '<cmd>vsplit<CR>')
-- vim.keymap.del("n", "<Leader>sh")
vim.keymap.set("n", "<Leader>sh", '<cmd>split<CR>')

-- highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- spell check 
vim.o.spell = true
vim.o.spelllang = 'en_us'
vim.keymap.set('n', '<leader>.', 'z=', { desc = 'Spell suggestions' })

-- change word boundries
vim.opt.iskeyword:append({ '_', '-' })


vim.o.signcolumn = 'yes:1'
vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },
    virtual_text = true,
    virtual_lines = false,
    jump = { float = true },
    signs = { priority = 10000 }, -- add this line
}
