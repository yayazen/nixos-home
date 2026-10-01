{ self, ... }: {
  
  flake.nixosModules.laptop = {
    imports = with self.nixosModules; [
      bluetooth
      upower
      udisks2

      greetd
      hyprland
      niri

      systemd-boot
    ];

    networking.networkmanager.enable = true;
    time.timeZone = "Europe/Paris";

    i18n.defaultLocale = "fr_FR.UTF-8";
  };
}
