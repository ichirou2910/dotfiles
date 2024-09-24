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
      name = "Brave Web Browser";
      genericName = "Web Browser";
      comment = "Access the Internet";
      exec = "${pkgs.brave}/bin/brave --enable-features=UseOzonePlatform --enable-wayland-ime %U";
      icon = "brave-browser";
      terminal = false;
      startupNotify = true;
      type = "Application";
      categories = [ "Network" "WebBrowser" ];
      mimeType = [
        "application/pdf" "application/rdf+xml" "application/rss+xml" "application/xhtml+xml"
        "application/xhtml_xml" "application/xml" "image/gif" "image/jpeg" "image/png"
        "image/webp" "text/html" "text/xml" "x-scheme-handler/http" "x-scheme-handler/https"
      ];
      actions = {
        "new-window" = {
          name = "New Window";
          exec = "${pkgs.brave}/bin/brave";
        };

        "new-private-window" = {
          name = "New Incognito Window";
          exec = "${pkgs.brave}/bin/brave --incognito";
        };
      };
    };
  };
}
