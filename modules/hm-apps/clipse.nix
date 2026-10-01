_: {
  flake.homeModules.clipse =
    { pkgs, ... }:
    {
      services.clipse = {
        enable = true;
      };
    };
}
