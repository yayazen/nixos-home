_: {
  flake.homeModules."kitty" =
    { config, ... }:
    {

      programs.kitty = {
        enable = true;
        enableGitIntegration = true;
        shellIntegration.enableZshIntegration = true;
        extraConfig = ''
          enable_audio_bell no
        ''
        + (
          if config.programs.zsh.enable then
            ''
              shell ${config.programs.zsh.package}/bin/zsh
            ''
          else
            ""
        );
      };
    };
}
