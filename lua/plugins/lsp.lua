return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
      {
        -- Installs LSP servers and CLI tools (formatters, tree-sitter CLI) on startup
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
          ensure_installed = {
            "lua-language-server",
            "basedpyright", -- pip-based, so it doesn't need node like pyright does
            "ruff",
            "stylua",
            "tree-sitter-cli", -- required by nvim-treesitter (main) to build parsers
          },
        },
      },
    },
    config = function()
      -- Advertise cmp completion + file-operation capabilities to LSP servers
      local capabilities = vim.tbl_deep_extend(
        "force",
        require("cmp_nvim_lsp").default_capabilities(),
        require("lsp-file-operations").default_capabilities()
      )
      vim.lsp.config("*", { capabilities = capabilities })

      -- Installed servers are enabled automatically (stylua is only used as a formatter via conform)
      require("mason-lspconfig").setup({
        automatic_enable = { exclude = { "stylua" } },
      })

      -- Keybindings (apply when any LSP attaches).
      -- K (hover) is a Neovim default and is not redefined here.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          local map = function(mode, key, action, desc)
            vim.keymap.set(mode, key, action, { buffer = buf, desc = desc })
          end

          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "gr", vim.lsp.buf.references, "Find references")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
          map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
        end,
      })

      -- Diagnostic display settings
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        float = { border = "rounded" },
      })
    end,
  },
  {
    -- Neovim API / plugin type info for lua_ls (replaces globals = { 'vim' })
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
