{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.hyprpanel = {
    enable = true;
    settings = {
      scalingPriority = "hyprland";
      layout = {
        bar.layouts = {
          "0" = {
            left = [
              "dashboard"
              "workspaces"
            ];
            middle = [ "media" ];
            right = [
              "volume"
              "systray"
              "notifications"
            ];
          };
        };
      };

      bar.launcher.autoDetectIcon = true;
      bar.workspaces = {
        show_numbered = true;
        workspaceMask = false;
        ignored = "-98";
      };

      menus.power.confirmation = false;

      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.unit = "metric";
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;

      theme.bar.transparent = true;

      theme.font = {
        name = "CaskaydiaCove NF";
        size = "8px";
      };

    };
  };
}
