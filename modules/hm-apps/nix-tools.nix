_: {
  flake.homeModules.nix-tools =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        nixfmt
        nix-output-monitor
      ];
    };
}
