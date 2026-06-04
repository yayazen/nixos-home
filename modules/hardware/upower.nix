_: {
  flake.nixosModules.hardware.upower = {
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
  };
}
