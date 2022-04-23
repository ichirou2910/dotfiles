local wezterm = require("wezterm")

return {
	-- Font
	font = wezterm.font_with_fallback({
		{ family = "ComicCodeLigatures Nerd Font", scale = 1.0 },
	}),
	freetype_load_target = "Light",
	freetype_render_target = "HorizontalLcd",
	harfbuzz_features = { "calt=0", "clig=0", "liga=1" },
	font_size = 10.0,
	line_height = 1.2,
	custom_block_glyphs = true,

	-- Window
	window_decorations = "NONE",
	window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 10,
	},

	-- Theme
	colors = {
		foreground = "#c8ccd4",
		background = "#1b1f27",
		ansi = { "#1e222a", "#e06c75", "#98c379", "#e5c07b", "#61afef", "#c678dd", "#56b6c2", "#abb2bf" },
		brights = { "#545862", "#e06c75", "#98c379", "#e5c07b", "#61afef", "#c678dd", "#56b6c2", "#abb2bf" },
	},

	-- Misc
	adjust_window_size_when_changing_font_size = false,
	hide_tab_bar_if_only_one_tab = true,
}
