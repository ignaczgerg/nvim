local strip = require("util.python_strip")

vim.keymap.set("n", "<leader>rc", function() strip.remove_comments(0) end, { buffer = true, desc = "Remove comments" })
vim.keymap.set("n", "<leader>rd", function() strip.remove_docstrings(0) end, { buffer = true, desc = "Remove docstrings" })
