{pkgs, lib, ...}: 
{
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "FantasqueSansMono" "JetBrainsMono" ]; })
      win-fonts
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "FantasqueSansM Nerd Font" "JetBrainsMono Nerd Font" ];
      };
    };
  };
}
