{ inputs, lib, ... }:
{
  flake.lib.email.mkMailBox =
    let
      pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };

      notifyCmd = pkgs.writeShellScriptBin "notify-new-mail" ''
        #${pkgs.runtimeShell}
        set -e

        export PATH="${
          lib.makeBinPath (
            with pkgs;
            [
              notmuch
              afew
              libnotify
              jq
              uutils-coreutils-noprefix
            ]
          )
        }"

        notmuch new && afew -t -n
      '';
    in
    {
      realName,
      address,
      userName ? address,
      mailboxPath,
    }:
    {
      inherit realName address userName;
      mbsync = {
        enable = true;
        create = "both";
      };
      msmtp.enable = true;

      notmuch = {
        enable = true;
        neomutt = {
          enable = true;
          virtualMailboxes = [ ];
        };
      };

      neomutt = {
        enable = true;
        showDefaultMailbox = false;
      };

      signature = {
        showSignature = "append";
        text = ''
          ${realName}
        '';
      };

      imapnotify = {
        enable = true;
        boxes = [ "Inbox" ];
        onNotify = "${pkgs.isync}/bin/mbsync ${mailboxPath}";
        onNotifyPost = "${notifyCmd}/bin/notify-new-mail";
      };
    };

  flake.homeModules.email =
    {
      config,
      lib,
      ...
    }:
    {
      programs = {
        mbsync = {
          enable = true;
        };
        msmtp.enable = true;
      };

      services.imapnotify.enable = true;
      #services.dunst.enable = true;

      accounts.email = {
        maildirBasePath = lib.mkDefault "mail";
      };
    };
}
