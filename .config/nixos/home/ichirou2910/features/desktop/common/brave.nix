{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    brave
  ];

  xdg.desktopEntries = {
    "brave-browser" = {
      exec = "${pkgs.brave}/bin/brave --enable-features=UseOzonePlatform --enable-wayland-ime";
      icon = "brave-browser";
      name = "Brave Web Browser";
    };
  };
}
