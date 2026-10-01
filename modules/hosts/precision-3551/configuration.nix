{
  inputs,
  self,
  ...
}:
let
  username = "yanis";
  hostname = "precision-3551";
  system = "x86_64-linux";
in
{
  flake.nixosConfigurations."${hostname}" = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      {
        imports = [ ./_hardware-configuration.nix ];

        system.stateVersion = "26.05";
        networking.hostName = hostname;
      }
      yanis
      laptop
    ];
  };

  flake.homeConfigurations."${username}@${hostname}" =
    inputs.home-manager.lib.homeManagerConfiguration
      {
        pkgs = import inputs.nixpkgs { inherit system; };
        modules = with self.homeModules; [
          {
            home.stateVersion = "25.05";
          }
          yanis
        ];
      };
}
