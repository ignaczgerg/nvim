require("config.vim-options")
require("config.lazy")
require("config.neovide")

vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

-- Move line down with Option+Down
vim.keymap.set('n', '<A-Down>', ':m .+1<CR>==', { noremap = true, silent = true })
-- Move line up with Option+Up
vim.keymap.set('n', '<A-Up>', ':m .-2<CR>==', { noremap = true, silent = true })

-- Visual mode: move selection down/up
vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<A-Up>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Swap line-start/end motions: $ goes to the first non-blank, _ to the end of the line.
-- '^' is used instead of '_' so operators stay characterwise (d$ no longer deletes the whole line).
vim.keymap.set({'n', 'x', 'o'}, '$', '^', {silent = true, desc = "Jump to first non-blank"})
vim.keymap.set({'n', 'x', 'o'}, '_', '$', {silent = true, desc = "Jump to end of line"})

-- <leader>rc / <leader>rd (remove comments / docstrings) live in after/ftplugin/python.lua

vim.keymap.set('n', '<leader>f', function()
        require("conform").format({ async = true })
        end, { desc = "Format file"})

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
