local wezterm = require("wezterm")

return {
	-- Font
	font = wezterm.font_with_fallback({
		{ family = "ComicCodeLigatures Nerd Font", scale = 1.0 },
	}),
	freetype_load_target = "Light",
	freetype_render_target = "HorizontalLcd",
	harfbuzz_features = { "calt=0", "clig=0", "liga=1" },
	use_cap_height_to_scale_fallback_fonts = false,
	font_size = 9.0,
	line_height = 1.2,

	-- Window
	window_decorations = "NONE",
	window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 5,
	},

	-- Theme
	colors = {
		-- Onedark
		-- foreground = "#c8ccd4",
		-- background = "#1b1f27",
		-- ansi = { "#1e222a", "#e06c75", "#98c379", "#e5c07b", "#61afef", "#c678dd", "#56b6c2", "#abb2bf" },
		-- brights = { "#545862", "#e06c75", "#98c379", "#e5c07b", "#61afef", "#c678dd", "#56b6c2", "#abb2bf" },

		-- Tokyonight
		foreground = "#c0caf5",
		background = "#1a1b26",
		cursor_bg = "#c0caf5",
		cursor_border = "#c0caf5",
		cursor_fg = "#1a1b26",
		selection_bg = "#33467C",
		selection_fg = "#c0caf5",

		ansi = { "#15161E", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6" },
		brights = { "#414868", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5" },
	},

	-- Misc
	adjust_window_size_when_changing_font_size = false,
	hide_tab_bar_if_only_one_tab = true,
}
