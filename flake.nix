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
