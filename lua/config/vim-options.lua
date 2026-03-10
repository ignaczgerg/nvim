vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.number = true
vim.opt.relativenumber = true

vim.api.nvim_set_hl(0, 'TermCursor', { fg = '#000000', bg = '#00FF00' })
vim.api.nvim_set_hl(0, 'TermCursorNC', { fg = '#000000', bg = '#555555' })

vim.g.terminal_color_0  = '#1a1b26'  -- black
vim.g.terminal_color_1  = '#f7768e'  -- red
vim.g.terminal_color_2  = '#9ece6a'  -- green
vim.g.terminal_color_3  = '#e0af68'  -- yellow
vim.g.terminal_color_4  = '#7aa2f7'  -- blue
vim.g.terminal_color_5  = '#bb9af7'  -- magenta
vim.g.terminal_color_6  = '#7dcfff'  -- cyan
vim.g.terminal_color_7  = '#a9b1d6'  -- white
