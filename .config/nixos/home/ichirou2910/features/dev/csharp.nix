{pkgs, ...}:
let 
  dotnet-full = with pkgs.dotnetCorePackages;
    combinePackages[
      sdk_6_0
      sdk_8_0
    ];
in {
  home.packages = with pkgs; [
    dotnet-full
  ];
}
