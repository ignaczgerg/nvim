return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    { '<C-p>', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
    { '<C-S-p>', '<cmd>Telescope find_files hidden=true no_ignore=true<cr>', desc = 'Find files (incl. hidden)' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
  },
}
