{ pkgs, ... } :
{
  programs.plasma.workspace = {
    colorScheme = "Nothing";
    cursor.theme = "Breeze";
    iconTheme = "Papirus-Dark";
    splashScreen.theme = "None";
    theme = "Nothing";
    windowDecorations = {
      library = "org.kde.kwin.aurorae";
      theme = "__aurorae__svg__Nothing";
    };
    wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Flow/contents/images_dark/5120x2880.jpg";
  };
}
