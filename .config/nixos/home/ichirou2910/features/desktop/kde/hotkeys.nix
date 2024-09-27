{
  programs.plasma.shortcuts = {
    # Set Meta+Q to Window Close
    "plasmashell"."manage activities" = "none,Meta+Q,Show Activity Switcher";
    "kwin"."Window Close" = ["Meta+Q" "Alt+F4,Alt+F4,Close Window"];

    # Set Meta+W to Brave shortcut
    "kwin"."Overview" = ",Meta+W,Toggle Overview";
    "services/brave-browser.desktop"."_launch" = "Meta+W";

    "services/kitty.desktop"."_launch" = "Meta+Return";

    "kwin"."Window Maximize" = ["Meta+M" "Meta+PgDown,Meta+PgDown,Minimize Window"];
    "kwin"."Window Minimize" = ["Meta+Shift+M" "Meta+PgDown,Meta+PgDown,Minimize Window"];
  };
}
