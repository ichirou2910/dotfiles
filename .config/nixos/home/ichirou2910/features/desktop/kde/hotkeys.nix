{
  programs.plasma.shortcuts = {
    # Set Meta+Q to Window Close
    "plasmashell"."manage activities" = "\\, Meta+Q\\, ,Meta+Q,Show Activity Switcher";
    "kwin"."Window Close" = ["Alt+F4" "Meta+Q,Alt+F4,Close Window"];

    # Set Meta+W to Brave shortcut
    "kwin"."Overview" = "\\, Meta+W\\, ,Meta+W,Toggle Overview";
    "services/brave-browser.desktop"."_launch" = "Meta+W";

    "services/kitty.desktop"."_launch" = "Meta+Return";
  };
}
