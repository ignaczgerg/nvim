vim.opt.termguicolors = true
vim.opt.background = "dark"
require("config.lazy")
require("config.vim-options")


local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>')

require('nvim-treesitter').install({ 'lua', 'python' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    if pcall(vim.treesitter.start) then
      vim.wo[0][0].foldmethod = 'expr'
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

vim.opt.foldlevel = 99
vim.cmd.colorscheme("tokyonight")
vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"
vim.api.nvim_set_hl(0, "Cursor", { fg = "#1a1b26", bg = "#7aa2f7" })
