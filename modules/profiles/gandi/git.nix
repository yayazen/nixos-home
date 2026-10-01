{ self, ... }:
{
  flake.homeModules.gandi =
    { pkgs, lib, ... }:
    let
      inherit (self.meta) gandi;
    in
    {
      programs.git = {
        settings = {
          user.name = gandi.userldap;
          user.email = gandi.email;
        };
        signing.key = gandi.signingKey;
      };

      # gitlab
      home.packages = [ pkgs.glab ];

      home.sessionVariables = {
        GITLAB_HOST = "gitlab.corp.gandi.net";
      };

      home.shellAliases = {
        # search and clone Gandi gitlab
        gcl = lib.mkForce ''
          echo | ${pkgs.fzf}/bin/fzf \
            --reverse \
            --prompt="Tab to search Gitlab repos > " \
            --preview "[ -n '{}' ] && glab repo view {} | CLICOLOR_FORCE=1 COLORTERM=truecolor ${pkgs.glow}/bin/glow --style=dark" \
            --bind "ctrl-w:execute-silent([ -n '{}' ] && glab repo view {} -w)" \
            --bind "tab:reload([ -n '{q}' ] && glab repo search -s \$(echo {q}) -F json -P 1000 | jq -r '.[].path_with_namespace')+clear-query" \
            --bind "enter:become([ -n '{}' ] && ${pkgs.gum}/bin/gum confirm 'Clone {} ?' && glab repo view {} -F json | jq -r '.ssh_url_to_repo' | ghq get -u)"
        '';

      };
    };
}
