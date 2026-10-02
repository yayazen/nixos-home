{ config, pkgs, ... }:
{
  flake.nixosModules.kde-plasma = {
    # Enable X11 / Wayland Display Server
    services.xserver.enable = true;

    # Enable SDDM Display Manager with Wayland support
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    # Enable KDE Plasma 6 Desktop Environment
    services.desktopManager.plasma6.enable = true;

    # Expose KDE Utilities
    environment.systemPackages = with pkgs.kdePackages; [
      kde-cli-tools
      kmon
    ];
  };
}
