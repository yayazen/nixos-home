{
  self,
  inputs,
  lib,
  ...
}:
let
  username = self.meta.gandi.username;
  hostname = "fr-par-01161";
  system = "x86_64-linux";
in
{
  flake.nixosConfigurations."${hostname}" =
    lib.warn "Gandi laptop is currently running Ubuntu 26.04, only home-manager is available" null;

  flake.homeConfigurations."${username}@${hostname}" =
    inputs.home-manager.lib.homeManagerConfiguration
      {
        pkgs = import inputs.nixpkgs { inherit system; };
        modules = [
          inputs.self.homeModules.gandi
          {
            home.stateVersion = "25.05";
          }
        ];
      };
}
