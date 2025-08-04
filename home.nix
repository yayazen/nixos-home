{
  config,
  pkgs,
  self,
  ...
}:
{
  imports = [
    ./firefox.nix
    ./fonts.nix
    ./git.nix
    ./hyprland
    ./kitty.nix
    ./nix.nix
    ./vim.nix
    ./shell/zsh.nix
    ./yazi.nix
    ./programs.nix
    ./kube.nix
  ];

  home.packages = [
    self.packages.${pkgs.stdenv.system}.nvim
  ];

  programs.home-manager.enable = true;

  home.username = "yanis";
  home.homeDirectory = "/home/yanis";

  home.stateVersion = "25.05";
}
