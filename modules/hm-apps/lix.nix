_: {
  flake.homeModules.lix =
    { pkgs, ... }:
    {
      nix = {
        package = pkgs.lix;
        settings = {
          experimental-features = "nix-command flakes";
        };
      };
    };
}
