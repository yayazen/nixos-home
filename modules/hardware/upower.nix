_: {
  flake.nixosModules.upower = {
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
  };
}
