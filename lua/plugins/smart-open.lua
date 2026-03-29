return {
  "danielfalk/smart-open.nvim",
  branch = "0.2.x",
  config = function()
    require("telescope").load_extension("smart_open")
  end,
  dependencies = {
    "kkharji/sqlite.lua",
  },
  keys = {
    { "<leader>fo", "<cmd>Telescope smart_open<cr>", desc = "Smart open" },
  },
}
