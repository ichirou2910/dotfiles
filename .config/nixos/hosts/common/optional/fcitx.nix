{ config, pkgs, ... }:
{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      plasma6Support = true;
      addons = with pkgs; [
        kdePackages.fcitx5-with-addons  # alternatively, kdePackages.fcitx5-qt
        kdePackages.fcitx5-unikey
      ];
      settings = {
        addons = {
          classicui.globalSection.Theme = "plasma";
        };
        globalOptions = {
          "Hotkey/TriggerKeys" = {
            "0" = "Control+Shift";
          };
          "Hotkey/AltTriggerKeys" = {
            "0" = "";
          };
        };
        inputMethod = {
          "Groups/0" = {
            "Name" = "Default";
            "Default Layout" = "us";
            "DefaultIM" = "unikey";
          };
          "Groups/0/Items/0" = {
            "Name" = "keyboard-us";
            "Layout" = null;
          };
          "Groups/0/Items/1" = {
            "Name" = "unikey";
            "Layout" = null;
          };
        };
      };
    };
  };
}
