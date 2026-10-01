_: {
  flake.nixosModules.greetd =
    { pkgs, lib, ... }:
    {
      services.xserver.displayManager.startx.enable = true;

      services.greetd = {
        enable = true;
        package = pkgs.greetd;
        restart = true;
        useTextGreeter = true; # avoid systemd boot messages interrupt TUI
        settings.default_session = {
          command = lib.mkDefault "${pkgs.tuigreet}/bin/tuigreet --greeting '★·.·´¯`·.·★·.·´¯`·.·★·.·´¯`·.·★·.·´¯`·.·★' --asterisks --remember --time --cmd niri-session";
          user = "greeter";
        };
      };
    };
}
