{
  programs.plasma.panels = [
    # main screen
    {
      floating = true;
      height = 45;
      hiding = "none";
      lengthMode = "fill";
      location = "bottom";
      widgets = [
        {
          kickoff = {
            icon = "distributor-logo-nixos";
          };
        }
        {
          iconTasks = {
            behavior = {
              showTasks = {
                onlyInCurrentScreen = true;
                onlyInCurrentDesktop = true;
                onlyInCurrentActivity = true;
                onlyMinimized = false;
              };
            };
            launchers = [ ];
          };
        }
        "org.kde.plasma.marginsseparator"
        "org.kde.plasma.systemtray"
        {
          digitalClock = {
            date.format = { 
              custom = "ddd, MMM d, yyyy";
            };
          };
        }
      ];
    }
  ];
}
