{ self, ... }:
{
  flake.nixosModules.gaming = {
    imports = with self.nixosModules; [
      systemd-boot

      bluetooth
      
      greetd
      kde-plasma
    ];

    nixpkgs.config.allowUnfree = true;

    networking.networkmanager.enable = true;
    time.timeZone = "Europe/Paris";

    i18n.defaultLocale = "fr_FR.UTF-8";
  };
}
