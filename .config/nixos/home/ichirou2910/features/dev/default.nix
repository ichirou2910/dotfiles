{pkgs, ...}:
let
  azuredatastudio-fixed = pkgs.unstable.azuredatastudio.overrideAttrs (_: rec {
    src = pkgs.fetchurl {
      name = "azuredatastudio-1.48.1.tar.gz";
      url = "https://azuredatastudio-update.azurewebsites.net/1.48.1/linux-x64/stable";
      sha256 = "sha256-bshkpcs1Ob7gdBWerjEWLJ/FUBjcwYb6Mv+cIIaxDWw=";
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

