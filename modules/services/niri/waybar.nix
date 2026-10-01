{
  flake.homeModules.niri =
    { pkgs, lib, ... }:
    let
      niri-waybar-on-overview = pkgs.writeScript "niri-waybar-on-overview" ''
        #!${pkgs.runtimeShell}
        set -euo pipefail

        export PATH="${
          lib.makeBinPath (
            with pkgs;
            [
              niri
              jq
              busybox
            ]
          )
        }"

        niri msg --json event-stream | jq -c --unbuffered '
          select(.OverviewOpenedOrClosed != null) | .OverviewOpenedOrClosed.is_open
        ' | while read -r is_open; do
          if [[ "$is_open" == "true" ]]; then
            pkill -SIGUSR1 waybar
          else
            pkill -SIGUSR2 waybar
          fi
        done
      '';

    in
    {
      programs.waybar = {
        enable = true;
        settings = {
          mainbar = {
            layer = "top";
            exclusive = false;
            start_hidden = true;
            reload_style_on_change = true;
            margin-top = 233;
            modules-center = [
              "network"
              "custom/separator"
              "battery"
              "custom/separator"
              "clock"
            ];
            network = {
              format = "{ifname}";
              format-wifi = "{ipaddr}/{cidr} - {essid} ({signalStrength}%)";
              format-ethernet = "{ipaddr}/{cidr}";
              format-disconnected = "⚠ Disconnected";
            };
            battery = {
              format = "{icon}  {capacity}%";
              format-charging = "  {capacity}%";
              format-icons = [
                ""
                ""
                ""
                ""
                ""
              ];
            };
            clock = {
              format = "  {:%H:%M}";
            };
            "custom/separator" = {
              format = "󰇙";
            };
          };
        };
        style = ''
          @define-color primary rgba(255,255,255,0.8);

          * {
              font-family: "JetBrainsMono Nerd Font";
              font-weight: bold;
              background: transparent;
          }

          label.module {
              color: @primary;
              padding: 0 0.25em;
          }
        '';
      };

      systemd.user.services."niri-waybar-on-overview" = {
        Unit = {
          Description = "Script to show waybar when Niri overview is open";
          After = [
            "niri.service"
            "graphical-session.target"
          ];
          PartOf = [ "graphical-session.target" ];
        };

        Service = {
          ExecStart = niri-waybar-on-overview;
          Restart = "on-failure";
          RestartSec = 2;
        };

        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
    };
}
