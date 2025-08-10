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
    gcd = ''cd "$(ghq root)/$(ghq list | ${pkgs.fzf}/bin/fzf \
      --reverse \
      --preview "${pkgs.glow}/bin/glow $(ghq root)/{1}/README.md 2>/dev/null")"'';
  };

  programs.git = {
    enable = true;

    userName = utils.obfuscate "ltcayay";
    userEmail = "zyx.rammam@sinay";

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
