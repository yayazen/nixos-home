{ lib, ... }:
{
  flake.lib.email = rec {
    mkFilter =
      {
        query,
        tags,
        message,
      }:
      ''
        query = ${query}
        tags = ${builtins.concatStringsSep ";" tags}
        message = ${message}
      '';

    mkFilters =
      filters:
      lib.concatImapStrings (pos: f: ''
        [Filter.${toString pos}]
        ${mkFilter f}
      '') filters;
  };

  flake.homeModules.email =
    { lib, ... }:
    {
      programs.afew = {
        enable = true;
        extraConfig = lib.mkDefault ''
          [SpamFilter]
          spam_tag = spam 
          [KillThreadsFilter]
          [ListMailsFilter]
          [ArchiveSentMailsFilter]
          sent_tag = sent
          [InboxFilter]
        '';
      };
    };
}
