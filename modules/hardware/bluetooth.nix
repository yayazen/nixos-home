_: {
  flake.nixosModules.hardware.bluetooth = {
      # bluetooth services
      services.blueman.enable = true;
      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = false;
  };
}
