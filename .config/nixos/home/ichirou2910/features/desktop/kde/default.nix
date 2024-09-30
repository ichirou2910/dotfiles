{pkgs, ...}: 
let
  nothing-theme = pkgs.stdenv.mkDerivation {
    name = "nothing-theme";
    version = "latest";
    src = pkgs.fetchFromGitLab {
      owner = "jomada";
      repo = "nothing";
      rev = "853d548dc4b0d1a0bcfe78c3893bfbf4231fd073";
      hash = "sha256-Qw5H0yzirIde9JuqiBa4pcJz0QAnsZk/17U+Mgn1l7k=";
    };

    buildPhase = ''
      mkdir -p aurorae/themes
      mv aurorae/Nothing aurorae/themes/Nothing

      mkdir -p plasma/desktoptheme
      mv Nothing plasma/desktoptheme/Nothing

      mv look-and-feel plasma/look-and-feel
    '';

    installPhase = ''
      install -d $out/share
      cp -r aurorae color-schemes plasma wallpapers $out/share
    '';
  };
in
{
  imports = [
    ../common
    ./fonts.nix
    ./hotkeys.nix
    ./panels.nix
    ./workspace.nix
  ];

  # Themes
  home.packages = with pkgs; [
    papirus-icon-theme
    nothing-theme
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
    "kdeglobals"."General"."BrowserApplication" = "brave-browser.desktop";
    "kdeglobals"."General"."TerminalApplication" = "kitty";
    "kdeglobals"."General"."TerminalService" = "kitty.desktop";

    "kwinrc"."Wayland"."InputMethod[$e]" = "/run/current-system/sw/share/applications/fcitx5-wayland-launcher.desktop";
  };
  programs.plasma.workspace.wallpaper = "${nothing-theme}/share/wallpapers/Nothing1/contents/images/2396x1080.png";
}
