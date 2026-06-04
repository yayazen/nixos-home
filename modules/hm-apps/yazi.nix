_: {
  flake.homeModules.yazi = {

    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      shellWrapperName = "yy";
    };
  };
}
