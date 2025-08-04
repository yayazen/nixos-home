{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;
      preload = [
        "${./wallpaper.png}"
      ];

      wallpaper = [
        ",${./wallpaper.png}"
      ];
    };
  };
}
