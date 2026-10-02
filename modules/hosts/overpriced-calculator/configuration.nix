{
  inputs,
  self,
  ...
}:
let
  username = "yanis";
  hostname = "overpriced-calculator";
  system = "x86_64-linux";
  stateVersion = "26.05";
in
{
  flake.nixosConfigurations."${hostname}" = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      {
        imports = [ ./_hardware-configuration.nix ];

        system.stateVersion = stateVersion;
        networking.hostName = hostname;
      }
      yanis
      gaming
    ];
  };

  flake.homeConfigurations."${username}@${hostname}" =
    inputs.home-manager.lib.homeManagerConfiguration
      {
        pkgs = import inputs.nixpkgs { inherit system; };
        modules = with self.homeModules; [
          {
            home.stateVersion = stateVersion;
          }
          yanis
          gaming
        ];
      };
}
