{ ... }:
{
  flake.nixosModules.gaming =
    { config, pkgs, ... }:
    {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = false;
        dedicatedServer.openFirewall = false;
        gamescopeSession.enable = true;
      };

      hardware.graphics = {
        enable = true;
        enable32Bit = true; # Essential for 32-bit games
      };

      # System-level Gamescope wrapper for real-time priority
      programs.gamescope = {
        enable = true;
        capSysNice = true;
      };

      # Feral GameMode integration for performance tweaks on launch
      programs.gamemode.enable = true;
    };

  flake.homeModules.gaming =
    { pkgs, ... }:
    {
      programs.mangohud = {
        enable = true;
        enableSessionWide = true;
      };

      # User-space launchers and managers
      home.packages = with pkgs; [
        protonup-qt
        heroic
        lutris
      ];
    };
}
