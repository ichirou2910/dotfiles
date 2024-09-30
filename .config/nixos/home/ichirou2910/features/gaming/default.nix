{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  home.packages = with pkgs; [
    protonup-qt
  ];
}
