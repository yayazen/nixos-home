{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lix
    nixfmt
    nix-output-monitor
  ];
}
