{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./brave.nix
    ./discord.nix
    ./firefox.nix
    ./kdeconnect.nix
    ./kitty.nix
    ./syncthing.nix
    ./vscode.nix
    # ./font.nix
  ];

  home.packages = with pkgs; [
    libnotify
    insync
    telegram-desktop

    obsidian

    onlyoffice-bin_latest
    xmind
  ];

  xdg.portal.enable = true;
}
