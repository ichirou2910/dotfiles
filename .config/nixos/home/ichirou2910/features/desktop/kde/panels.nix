{
  programs.plasma.panels = [
    # main screen
    {
      screen = 0;
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
    # 2nd screen
    {
      screen = 1;
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
        {
          systemMonitor = {
            title = "Total CPU Use";
            showTitle = true;
            showLegend = true;
            displayStyle = "org.kde.ksysguard.piechart";
            sensors = [
              {
                name = "cpu/all/usage";
                color = "212,21,21";
                label = "CPU %";
              }
            ];
          };
        }
        "org.kde.plasma.marginsseparator"
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
