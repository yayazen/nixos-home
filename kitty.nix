{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;

    enableGitIntegration = true;
    shellIntegration.enableZshIntegration = true;

    extraConfig = ''
      shell ${config.programs.zsh.package}/bin/zsh
    '';
  };
}
