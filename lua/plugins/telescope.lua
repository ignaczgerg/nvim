return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    require('telescope').setup({})
    require('telescope').load_extension('fzf')
  end,
  keys = {
    { '<C-p>', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
    { '<C-S-p>', '<cmd>Telescope find_files hidden=true no_ignore=true<cr>', desc = 'Find files (incl. hidden)' },
    -- <C-S-p> only works in Neovide / terminals with the kitty keyboard protocol
    { '<leader>fF', '<cmd>Telescope find_files hidden=true no_ignore=true<cr>', desc = 'Find files (incl. hidden)' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help tags' },
    { '<leader>fr', '<cmd>Telescope resume<cr>', desc = 'Resume last picker' },
    { '<leader>fd', '<cmd>Telescope diagnostics<cr>', desc = 'Diagnostics' },
  },
}
