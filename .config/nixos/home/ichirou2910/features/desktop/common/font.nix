{pkgs, ...}: {
  fontProfiles = {
    enable = true;
    monospace = {
      family = "Fantasque Sans Mono Nerd Font";
      package = pkgs.nerdfonts.override {fonts = ["FantasqueSansMono" "JetBrainsMono"];};
    };
    regular = {
      family = "Noto";
      package = pkgs.noto-fonts;
    };
  };
}