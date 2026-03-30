vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.foldlevel = 99
vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"

-- Cursor colors (applied on every colorscheme change)
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "Cursor", { fg = "#303446", bg = "#8caaee" })
    vim.api.nvim_set_hl(0, "TermCursor", { fg = "#303446", bg = "#8caaee" })
    vim.api.nvim_set_hl(0, "TermCursorNC", { fg = "#303446", bg = "#626880" })
  end,
})

