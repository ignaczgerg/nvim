return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  opts = {
    ensure_installed = { 'lua', 'python' },
  },
  config = function(_, opts)
    require('nvim-treesitter').setup(opts)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      callback = function()
        if pcall(vim.treesitter.start) then
          vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
          vim.wo[0][0].foldmethod = 'expr'
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end
      end,
    })
  end,
}
