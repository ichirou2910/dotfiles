{
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./kdeconnect.nix
    ./locale.nix
    ./nix-ld.nix
    ./openssh.nix
    ./steam-hardware.nix
    ./fonts.nix
  ]
  ++ (builtins.attrValues outputs.nixosModules);

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  programs.adb.enable = true;
  users.users.ichirou2910.extraGroups = ["adbusers"];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };
}
