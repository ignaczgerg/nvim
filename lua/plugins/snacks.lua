return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- Render images via the kitty graphics protocol (works over SSH).
    -- Opening a .png shows it; markdown image links are rendered inline.
    -- PNG needs no extra tools; other formats would require ImageMagick.
    image = { enabled = true },
  },
}
