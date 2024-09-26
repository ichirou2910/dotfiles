{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports =
    [
      # inputs.impermanence.nixosModules.home-manager.impermanence
      ../features/cli
      ../features/nvim.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "ichirou2910";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "24.05";
    sessionPath = ["$HOME/.local/bin"];
    # sessionVariables = {
    #   FLAKE = "$HOME/Documents/NixConfig";
    # };
  };
}

