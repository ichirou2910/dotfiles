{
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  hosts = lib.attrNames outputs.nixosConfigurations;
in {
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
}
