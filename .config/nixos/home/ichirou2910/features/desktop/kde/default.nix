{pkgs, ...}: {
  imports = [
    # <plasma-manager/modules>
    ../common
  ];

  xdg.portal.extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];

  xdg.portal.config = {
    common = {
      default = [
        "kde"
      ];
    };
  };

  programs.plasma = {
    enable = true;

    # hotkeys.commands."kitty" = {
    #   name = "Kitty";
    #   key = "Meta+Enter";
    #   command = "kitty";
    # };
  };
}
