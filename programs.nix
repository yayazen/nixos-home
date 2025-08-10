{ pkgs, ... }:
{
  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.packages = with pkgs; [
    just
    clipse # clipboard manager
    zathura # pdf viewer
    jq
  ];
}
