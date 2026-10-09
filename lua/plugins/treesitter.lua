return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  -- Mason puts tree-sitter-cli on PATH; it's needed to build parsers
  dependencies = { 'mason-org/mason.nvim' },
  config = function()
    -- On the main branch, setup() no longer takes ensure_installed; install() does
    -- (already-installed parsers are skipped).
    require('nvim-treesitter').install({
      'lua', 'python', 'bash', 'json', 'yaml', 'toml',
      'markdown', 'markdown_inline', 'vim', 'vimdoc', 'regex', 'query',
    })

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
