{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./global
    ./features/desktop/kde
    ./features/dev
    ./features/gaming
    ./features/remote
  ];

  # Kitty overrides
  programs.kitty.font.size = lib.mkForce 11.5;
}
