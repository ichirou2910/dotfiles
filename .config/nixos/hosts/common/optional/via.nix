{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    via
  ];
  services.udev.packages = [ pkgs.via ];
}
