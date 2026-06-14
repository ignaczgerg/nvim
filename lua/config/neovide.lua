-- Neovide GUI settings (https://neovide.dev/configuration.html)
-- Only applied when running inside Neovide; ignored in a terminal.
if not vim.g.neovide then
  return
end

-- Font (Neovide renders its own font instead of the terminal's)
vim.o.guifont = "JetBrainsMono Nerd Font:h14"

-- Render
vim.g.neovide_scale_factor = 1.0
vim.g.neovide_window_blurred = true
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_floating_shadow = true

-- Animated cursor (https://neovide.dev/features.html#animated-cursor)
vim.g.neovide_cursor_animation_length = 0.13
vim.g.neovide_cursor_trail_size = 0.8
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_animate_command_line = true

-- Cursor particle trail effect: "railgun" | "torpedo" | "pixiedust" |
-- "sonicboom" | "ripple" | "wireframe" | "" (disabled)
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
vim.g.neovide_cursor_vfx_particle_density = 7.0
vim.g.neovide_cursor_vfx_particle_speed = 10.0

-- Smooth scrolling
vim.g.neovide_scroll_animation_length = 0.3

-- Dynamically resize the font with Ctrl +/- and reset with Ctrl 0
local function set_scale(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function() set_scale(1.1) end, { desc = "Neovide: zoom in" })
vim.keymap.set("n", "<C-->", function() set_scale(1 / 1.1) end, { desc = "Neovide: zoom out" })
vim.keymap.set("n", "<C-0>", function() vim.g.neovide_scale_factor = 1.0 end, { desc = "Neovide: reset zoom" })
