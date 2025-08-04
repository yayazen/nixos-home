{ pkgs, ... }:
{
  fonts = {
    fontconfig.enable = true; # ensure fontconfig cache is generated
  };
  home.packages = with pkgs; [
    nerd-fonts.symbols-only
    nerd-fonts.caskaydia-cove
  ];
}
