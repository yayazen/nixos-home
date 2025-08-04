{ config, pkgs, ... }:
let
  rycee = import (pkgs.fetchFromGitLab {
    repo = "nur-expressions";
    owner = "rycee";
    rev = "27c945a6450d42c62f7e41019d7931b426bb786f";
    hash = "sha256-6foT7Sflve4XuLnBKkgN9b9IP4FvdoBA2XQ2IyXmbog=";
  }) { inherit pkgs; };
in
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "fr" ];
    profiles.default = {
      isDefault = true;
      settings = {
        extensions.autoDisableScopes = 0;
      };
      extensions.packages = with rycee.firefox-addons; [
        ublock-origin
        bitwarden
        darkreader
        vimium
      ];
      bookmarks = {
        force = true;
        settings = [
          {
            toolbar = false;
            name = "Nix";
            bookmarks = [
              {
                name = "NixOS Search";
                url = "https://search.nixos.org/packages";
              }
              {
                name = "Home Manager Search";
                url = "https://home-manager-options.extranix.com";
              }
              {
                name = "Noogle";
                url = "https://noogle.dev";
              }

            ];
          }
        ];
      };
    };
  };
}
