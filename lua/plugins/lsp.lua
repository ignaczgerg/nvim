return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "pyright" },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function(_, opts)
      require("mason").setup()
      require("mason-lspconfig").setup(opts)

      -- Per-server settings
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
          },
        },
      })

      -- Keybindings (apply when any LSP attaches)
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local buf = args.buf
          local map = function(mode, key, action, desc)
            vim.keymap.set(mode, key, action, { buffer = buf, desc = desc })
          end

          map('n', 'K', vim.lsp.buf.hover, 'Hover info')
          map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
          map('n', 'gr', vim.lsp.buf.references, 'Find references')
          map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
          map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
          map('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic')
          map('n', '[d', vim.diagnostic.goto_prev, 'Prev diagnostic')
        end,
      })

      -- Diagnostic display settings
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        float = { border = 'rounded' },
      })
    end,
  },
}
