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
  };
}
