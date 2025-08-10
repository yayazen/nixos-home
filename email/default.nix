{
  config,
  pkgs,
  lib,
  ...
}:
let
  utils = import ../utils { inherit lib; };

  defaultRealName = "Yanis Mammar";

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

    notmuch new
    afew -t -n # remove new tag and filter

    MAIL_ID="$(notmuch search --output=threads --sort=newest-first --limit=1 tag:inbox)"
    MAIL_HEADERS="$(notmuch show --body=false --format=json ''${MAIL_ID} | jq .[0][0][0].headers)"

    ${pkgs.libnotify}/bin/notify-send 'New mail' "
      From: $(jq -r '.From' <<< "$MAIL_HEADERS")
      Subject: $(jq -r '.Subject' <<< "$MAIL_HEADERS")
    "
  '';

  mkMailBox =
    {
      realName ? defaultRealName,
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
in
{
  imports = [
    ./neomutt.nix
    ./notmuch.nix
    ./mailcap.nix
    ./afew.nix
  ];

  programs = {
    mbsync.enable = true;
    msmtp.enable = true;
  };

  services.imapnotify.enable = true;

  accounts.email = {
    maildirBasePath = "mail";

    accounts."gmail" =
      (mkMailBox {
        address = utils.obfuscate "moc.liamg@9rammamsinay";
        mailboxPath = "gmail";
      })
      // {
        primary = true;
        flavor = "gmail.com";
        passwordCommand = "${pkgs.uutils-coreutils-noprefix}/bin/cat /home/yanis/gmail";
      };
  };
}
