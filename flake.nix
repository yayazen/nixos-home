{
  description = "My NixOS modules";

  outputs =
    inputs@{ nixpkgs, flake-parts, ... }:
    let
      inherit (nixpkgs.lib) hasPrefix;
      inherit (nixpkgs.lib.fileset) fileFilter toList;

      import-tree =
        path: toList (fileFilter (file: file.hasExt "nix" && !(hasPrefix "_" file.name)) path);
    in
    flake-parts.lib.mkFlake { inherit inputs; } { imports = import-tree ./modules; };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

#  outputs =
#    {
#      self,
#      nixpkgs,
#      home-manager,
#      nvf,
#      ...
#    }:
#    {
#      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
#
#      packages.x86_64-linux.nvim =
#        (nvf.lib.neovimConfiguration {
#          pkgs = nixpkgs.legacyPackages.x86_64-linux;
#          modules = [ ./packages/nvf.nix ];
#        }).neovim;
#
#      homeConfigurations."yanis@nixos" = home-manager.lib.homeManagerConfiguration {
#        pkgs = nixpkgs.legacyPackages.x86_64-linux;
#        modules = [ ./home.nix ];
#        extraSpecialArgs = { inherit self; };
#      };
#    };
#}
