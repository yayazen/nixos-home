_: {
  flake.nixosModules.hyprland = {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    security.pam.services.hyprlock = { }; # needed for hyprlock login
  
    services.libinput.enable = true;
  };
}
