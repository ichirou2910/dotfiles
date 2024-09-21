{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [vesktop];

  # home.persistence = {
  #   "/persist/${config.home.homeDirectory}" = {
  #     directories = [
  #       ".config/vesktop/sessionData"
  #       ".config/vesktop/settings"
  #     ];
  #   };
  # };
}
