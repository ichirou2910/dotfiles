{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./global
    ./features/desktop/kde
    ./features/dev
  ];
}
