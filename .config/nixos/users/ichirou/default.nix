{
  config,
  inputs,
  pkgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  nix.settings.trusted-users = [ "ichirou" ];

  users = {
    users = {
      ichirou = {
        shell = pkgs.zsh;
        uid = 1000;
        isNormalUser = true;
        extraGroups = ifTheyExist [
          "wheel"
          "network"
          "games"
          "audio"
          "video"
          "input"
        ];
        group = "ichirou";
        # openssh.authorizedKeys.keys = [
        # ];
      };
    };
    groups = {
      ichirou = {
        gid = 1000;
      };
    };
  };
  programs.zsh.enable = true;

}
