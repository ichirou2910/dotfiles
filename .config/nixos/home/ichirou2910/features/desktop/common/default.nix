{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./brave.nix
    ./discord.nix
    ./firefox.nix
    ./kitty.nix
    ./vscode.nix
    ./kdeconnect.nix
    # ./font.nix
  ];

  home.packages = with pkgs; [
    libnotify
    insync
    telegram-desktop
  ];

  xdg.portal.enable = true;
}
