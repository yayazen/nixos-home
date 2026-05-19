let
  wallpaper = ./nix-wallpaper.png;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;
      preload = [
        "${wallpaper}"
      ];

      wallpaper = [
        ",${wallpaper}"
      ];
    };
  };
}
