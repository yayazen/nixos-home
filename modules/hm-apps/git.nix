_: {

  flake.homeModules.git =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      home.packages = [ pkgs.ghq ];

      programs.delta.enable = true;

      programs.git = {
        enable = true;

        settings = {
          user.name = lib.mkDefault config.home.username;
          init.defaultBranch = "master";
          ghq = {
            root = "~/dev";
          };
          push.autoSetupRemote = true;
          commit.gpgSign = true;
        };

        ignores = [
          ".direnv"
        ];
      };

      programs.gh = {
        enable = true;
        gitCredentialHelper.enable = true;
        extensions = [
          pkgs.gh-dash
          pkgs.gh-eco
        ];
        settings = {
          version = 1;
          git_protocol = "ssh";
        };
      };
    };

  flake.homeModules.git-custom-aliases =
    { pkgs, ... }:
    {
      home.shellAliases = {
        # cd to a cloned ghq repo
        gcd = ''
          repo="$(ghq list | ${pkgs.fzf}/bin/fzf \
                --reverse \
                --preview "CLICOLOR_FORCE=1 COLORTERM=truecolor ${pkgs.glow}/bin/glow --style=dark $(ghq root)/{1}/README.md 2>/dev/null")" \
            && [ -n "$repo" ] && cd "$(ghq root)/$repo"'';

        # search and clone github repositories
        gcl = ''
          echo | ${pkgs.fzf}/bin/fzf \
            --reverse \
            --prompt="Tab to search GH repos > " \
            --preview "[ -n '{}' ] && gh repo view {} | CLICOLOR_FORCE=1 COLORTERM=truecolor ${pkgs.glow}/bin/glow --style=dark" \
            --bind "ctrl-w:execute-silent([ -n '{}' ] && gh repo view {} -w)" \
            --bind "tab:reload([ -n '{q}' ] && gh search repos \$(echo {q}) --json fullName -q '.[].fullName')+clear-query" \
            --bind "enter:become([ -n '{}' ] && ${pkgs.gum}/bin/gum confirm 'Clone {} ?' && gh repo view {} --json sshUrl -q '.sshUrl' | ghq get -u)"
        '';
      };
    };
}
