{ pkgs, lib, config, ... }:

{
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableZshIntegration = true;
    };
    font = {
      name = "monospace";
      size = lib.mkDefault 10.5;
    };
    settings = {
      adjust_line_height = "140%";
      adjust_column_width = "100%";
    };
    extraConfig = ''
      modify_font underline_position 4
      modify_font baseline -1

      background #16181a
      foreground #ffffff
      selection_background #3c4048
      selection_foreground #ffffff
      url_color #4fd6be
      cursor #ffffff
      cursor_text_color #222436

      # Tabs
      active_tab_background #82aaff
      active_tab_foreground #1e2030
      inactive_tab_background #2f334d
      inactive_tab_foreground #545c7e
      #tab_bar_background #1b1d2b

      # Windows
      active_border_color #82aaff
      inactive_border_color #2f334d

      # normal
      color0 #16181a
      color1 #ff6e5e
      color2 #5eff6c
      color3 #f1ff5e
      color4 #5ea1ff
      color5 #bd5eff
      color6 #5ef1ff
      color7 #ffffff

      # bright
      color8 #3c4048
      color9 #ff6e5e
      color10 #5eff6c
      color11 #f1ff5e
      color12 #5ea1ff
      color13 #bd5eff
      color14 #5ef1ff
      color15 #ffffff

      # extended colors
      color16 #ffbd5e
      color17 #ff6e5e
    '';
  };
}
