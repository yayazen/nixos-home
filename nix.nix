{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lix
    nixfmt-rfc-style
    nix-output-monitor
  ];
}
