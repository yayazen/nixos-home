_: {
  flake.nixosModules.niri = {
    programs.niri = {
      enable = true;
    };
  };

  flake.homeModules.niri =
    { pkgs, ... }:
    {
      home.file.".config/niri/config.kdl".source = ./niri-config.kdl;

      home.packages = with pkgs; [
        brightnessctl
        xwayland-satellite
      ];

      programs = {
        vicinae = {
          # launcher
          enable = true;
          systemd.enable = true;
        };

        hyprlock.enable = true; # lock screen
      };

      services = {
        awww.enable = true; # wallpaper

        mako = {
          # notification daemon
          enable = true; 
        };
      };

    };
}
