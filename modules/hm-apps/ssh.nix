_: {
  flake.homeModules.ssh =
    { pkgs, ... }:
    {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        package = pkgs.openssh;
      };
    };
}
