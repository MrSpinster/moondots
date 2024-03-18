-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.enable_tab_bar = false
config.font = wezterm.font("Hack Nerd Font Mono", { weight = "Regular", italic = false })
config.font_size = 11.5
-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.9
config.text_background_opacity = 0.8
-- config.window_background_image = "/home/maestromoon/Pictures/wallpapers/cat_pacman.png"

-- and finally, return the configuration to wezterm
return config
