require("config.lazy")
require("config.vim-options")

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

-- Remap of _ to jump to the end of the line instead of beginning [this was $ before]
vim.keymap.set({'n', 'v', 'o'}, '_', '$', {noremap = true, silent = true, desc = "Jump to the end of the line"})
-- Remap of _ to jump to the end of the line instead of beginning [this was $ before]
vim.keymap.set({'n', 'v', 'o'}, '$', '_', {noremap = true, silent = true, desc = "Jump to the beginning of the line"})

vim.keymap.set('n', '<leader>rc', function()
        vim.cmd([[g/^\s*#\s/d]]) -- delete everything after #
        vim.cmd([[%s/\s*#\s.*$//e]]) -- strip inline # comments
        end, { desc = "Remove comments" })

vim.keymap.set('n', '<leader>rd', function ()
        vim.cmd([[%s/\s*"""\_.\{-}"""//ge]])
        end, { desc = "Remove docstrings"})


vim.keymap.set('n', '<leader>f', function()
        require("conform").format({ async = true })
        end, { desc = "Format file"})

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
