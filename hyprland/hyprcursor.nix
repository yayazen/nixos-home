{ pkgs, ... }:
{
  home.pointerCursor = {
    enable = true;
    package = pkgs.dracula-theme;
    name = "Dracula-cursors";
    hyprcursor = {
      enable = true;
      size = 16;
    };
  };
}
