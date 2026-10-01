{ self, ... }:
{
  flake.meta.gandi = {
    username = self.lib.obfuscate "rammam-sinay";
    userldap = self.lib.obfuscate "rammam.sinay";
    realName = self.lib.obfuscate "rammaM sinaY";
    email = self.lib.obfuscate "ten.idnag@rammam.sinay";
    signingKey = "8362B1F013861658!";
  };

  flake.homeModules.gandi =
    { pkgs, config, ... }:
    let
      inherit (self.meta) gandi;
    in
    {
      imports = with self.homeModules; [
        fonts
        lix
        nix-tools

        firefox
        email
        taskwarrior

        kitty
        shell
        nvim
        yazi

        git
        git-custom-aliases
        gpg
        direnv
        password-store

        ssh
      ];

      home.packages = with pkgs; [
        just
        clipse
        zathura
        jq
        glab
        mumble
        autorandr
      ];

      home.username = gandi.username;
      home.homeDirectory = "/home/${config.home.username}";

      programs.password-store.settings = {
        PASSWORD_STORE_DIR = "$HOME/dev/gitlab.corp.gandi.net/gandi/squad-hosting/pass";
      };
    };
}
