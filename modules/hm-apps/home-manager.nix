_: {
  flake.homeModules.home-manager =
    { config, pkgs, ... }:
    {
      home.packages = [
        pkgs.home-manager
      ];
    };
}
