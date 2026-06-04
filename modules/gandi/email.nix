{ self, ... }:
{
  flake.homeModules.gandi =
    {
      pkgs,
      lib,
      ...
    }:
    let
      inherit (self.meta) gandi;
    in
    {
      accounts.email.accounts."gandi" =
        (self.lib.email.mkMailBox {
          realName = gandi.realName;
          address = gandi.email;
          mailboxPath = "gandi";
          userName = gandi.userldap;
        })
        // {
          primary = true;
          passwordCommand = "${pkgs.uutils-coreutils-noprefix}/bin/cat /home/yanis-mammar/.gandi-mail";
          imap = {
            host = "mail12.gandi.net";
            port = 993;
          };
          smtp = {
            host = "mail12.gandi.net";
            port = 465;
          };
        };

      programs.afew.extraConfig = ''
        [SpamFilter]
        spam_tag = spam 
        [KillThreadsFilter]
        [ListMailsFilter]
        [ArchiveSentMailsFilter]
        sent_tag = sent
        ${self.lib.email.mkFilters [
          {
            message = "Tag all alert messages";
            query = "from:alertmanager@gandi.net or from:noreply@statuspage.io";
            tags = [
              "+alert"
              "-new"
              "-inbox"
            ];
          }
          {
            message = "Tag all gitlab messages";
            query = "from:gitlab@gandi.net";
            tags = [
              "+gitlab"
              "-new"
              "-inbox"
            ];
          }
          {
            message = "Tag Gandi no-reply";
            query = "from:help@support.gandi.net or from:no-reply@gandi.net";
            tags = [
              "+gandi-no-reply"
              "-new"
              "-inbox"
            ];
          }
          {
            message = "Tag inbox messages";
            query = "tag:new";
            tags = [
              "+inbox"
              "-new"
            ];
          }
        ]}
        [InboxFilter] 
      '';

      programs.neomutt.extraConfig = lib.mkAfter ''
        # gandi virtual mailboxes
        ${self.lib.email.mkVirtualBoxes [
          {
            name = "Alert";
            query = "tag:alert";
          }
          {
            name = "Gandi No-Reply";
            query = "tag:gandi-no-reply";
          }
          {
            name = "Gitlab";
            query = "tag:gitlab";
          }
        ]}
      '';
    };
}
