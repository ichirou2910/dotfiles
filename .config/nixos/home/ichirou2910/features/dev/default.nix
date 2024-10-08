{pkgs, ...}:
let
  azuredatastudio-fixed = pkgs.azuredatastudio.overrideAttrs (_: rec {
    src = pkgs.fetchurl {
      name = "azuredatastudio-1.48.1.tar.gz";
      url = "https://azuredatastudio-update.azurewebsites.net/1.48.1/linux-x64/stable";
      sha256 = "sha256-0LCrRUTTe8UEDgtGLvxVQL8pA5dwA6SvZEZSDILr7jo=";
    };
  });

in 
 {
  imports = [
    ./csharp.nix
  ];

  home.packages = with pkgs; [
    azuredatastudio-fixed
  ];
}

