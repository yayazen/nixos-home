{ config, pkgs, ... }:
{
  imports = [
    ./hyprcursor.nix
    ./hyprlock.nix
    ./hyprland.nix
    ./hyprpanel.nix
    ./hyprpaper.nix
  ];

  home.packages = with pkgs; [
    hyprnotify
  ];
}
