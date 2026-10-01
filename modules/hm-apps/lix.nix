_: {
  flake.homeModules.lix =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.lix
      ];

      nix = {
        package = pkgs.lix;
        settings = {
          experimental-features = "nix-command flakes";
        };
      };
    };
}
