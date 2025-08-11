{
  config,
  pkgs,
  lib,
  ...
}:
let
  utils = import ./utils { inherit lib; };

  signingKeys = {
    nixos = "096108F8E887C988!";
  };
in
{
  home.packages = [ pkgs.ghq ];

  home.shellAliases = {
    gcd = ''
      repo="$(ghq list | ${pkgs.fzf}/bin/fzf \
            --reverse \
            --preview "CLICOLOR_FORCE=1 COLORTERM=truecolor ${pkgs.glow}/bin/glow --style=dark $(ghq root)/{1}/README.md 2>/dev/null")" \
            && [ -n "$repo" ] && cd "$(ghq root)/$repo"'';
  };

  programs.git = {
    enable = true;

    userName = utils.obfuscate "nezayay";
    userEmail = utils.obfuscate "zyx.rammam@sinay";

    delta.enable = true;
    ignores = [
      ".direnv"
    ];

    signing.key = signingKeys.nixos; # TODO import it from nixOS config somehow

    extraConfig = {
      init.defaultBranch = "master";
      ghq = {
        root = "~/dev";
      };
      push.autoSetupRemote = true;
      commit.gpgSign = true;
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    extensions = [
      pkgs.gh-eco
    ];
    settings = {
      version = 1;
      git_protocol = "ssh";
    };
  };
}
