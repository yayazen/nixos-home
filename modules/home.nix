{ inputs, self, ... }:
let
  username = "yanis";
  host = "nixos";
in
{
  flake.homeConfigurations."${username}@${host}" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      {
        home.stateVersion = "25.05";
      }
      self.homeModules."${username}"
    ];
  };
}
