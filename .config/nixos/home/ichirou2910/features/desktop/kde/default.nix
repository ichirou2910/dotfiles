{pkgs, ...}: {
  imports = [
    ../common
    ./fonts.nix
    ./hotkeys.nix
    ./panels.nix
    ./workspace.nix
  ];

  xdg.portal.extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];

  xdg.portal.config = {
    common = {
      default = [
        "kde"
      ];
    };
  };

  programs.plasma.enable = true;
  programs.plasma.configFile = {
    "kwinrc"."Wayland"."InputMethod[$e]" = "/run/current-system/sw/share/applications/fcitx5-wayland-launcher.desktop";
  };
}
