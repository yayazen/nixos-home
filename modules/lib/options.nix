{ lib, flake-parts-lib, ... }:
let
  inherit (lib) types mkOption;
in
{
  options = {
    flake = flake-parts-lib.mkSubmoduleOptions {
      lib = mkOption {
        type = types.anything;
        default = { };
        description = ''
         Functions used in my config.
        '';
      };
    };
  };
}
