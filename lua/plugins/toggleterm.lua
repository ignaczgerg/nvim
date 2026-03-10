return {
  'akinsho/toggleterm.nvim',
  version = "*",
  event = "VeryLazy",
  config = function()
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = false,
      shading_factor = 1,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",  -- default direction
      close_on_exit = true,
      shell = "/bin/bash --login",
      float_opts = {
        border = "curved",
        winblend = 0,
      },
    })

    -- Terminal navigation keymaps
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], opts)
      vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]], opts)
      vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], opts)
      vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], opts)
    end

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end,

  keys = {
    { "<C-\\>", desc = "Toggle terminal" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float terminal" },
    { "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", desc = "Horizontal terminal" },
    { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical terminal" },
  },
}
