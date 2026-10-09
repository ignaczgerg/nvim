-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.foldlevel = 99
vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"

vim.opt.signcolumn = "yes"      -- keep text from shifting when signs appear
vim.opt.undofile = true         -- persistent undo
vim.opt.ignorecase = true
vim.opt.smartcase = true        -- case-sensitive search if it contains capitals
vim.opt.scrolloff = 8
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.updatetime = 250
vim.opt.cursorline = true

-- Cursor colors (gruvbox-material palette), applied on every colorscheme change.
-- This file is loaded before lazy.nvim so the autocmd also catches the startup colorscheme.
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "Cursor", { fg = "#282828", bg = "#7daea3" })
    vim.api.nvim_set_hl(0, "TermCursor", { fg = "#282828", bg = "#7daea3" })
    vim.api.nvim_set_hl(0, "TermCursorNC", { fg = "#282828", bg = "#5a524c" })
  end,
})
