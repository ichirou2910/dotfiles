{ config, pkgs, ... }:
{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      ignoreUserConfig = true;
      addons = with pkgs; [
        kdePackages.fcitx5-with-addons  # alternatively, kdePackages.fcitx5-qt
        fcitx5-unikey  # table input method support
      ];
      settings = {
        addons = {
          classicui.globalSection.Theme = "plasma";
        };
      };
    };
  };
}