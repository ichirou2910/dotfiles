{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users.ichirou2910 = {
    isNormalUser = true;
    description = "Le Anh Dung";
    openssh.authorizedKeys.keys = [
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
    ];
    packages = with pkgs; [
      pkgs.home-manager
    ];
    extraGroups = ifTheyExist [
      "audio"
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    useDefaultShell = true;
    ignoreShellProgramCheck = true;

    # hashedPasswordFile = config.sops.secrets.ichirou2910-password.path;
  };

  # home-manager.users.ichirou2910 = import ../../../../home/ichirou2910/${config.networking.hostName}.nix;
}
