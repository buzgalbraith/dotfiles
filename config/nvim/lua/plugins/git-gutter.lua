-- version control integration
return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    ---@module 'gitsigns'
    ---@type Gitsigns.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      signs = {
        add = { text = '+' }, ---@diagnostic disable-line: missing-fields
        change = { text = '~' }, ---@diagnostic disable-line: missing-fields
        delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
        topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
        changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
      },
  on_attach = function(bufnr)
    local gs = require 'gitsigns'

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
    end

    -- Navigation
    map('n', ']c', gs.next_hunk, 'Next git hunk')
    map('n', '[c', gs.prev_hunk, 'Prev git hunk')

    -- Actions
    map('n', '<leader>gs', gs.stage_hunk, '[G]it [S]tage hunk')
    map('n', '<leader>gr', gs.reset_hunk, '[G]it [R]eset hunk')
    map('n', '<leader>gp', gs.preview_hunk, '[G]it [P]review hunk')
    map('n', '<leader>gb', gs.blame_line, '[G]it [B]lame line')
  end,
    },
  },
}
