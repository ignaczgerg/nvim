return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
      lua = { "stylua" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
  },
}
