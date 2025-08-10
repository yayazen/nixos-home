{
  config,
  pkgs,
  lib,
  ...
}:
let
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
      ${f}
    '') filters;
in
{
  programs.afew = {
    enable = true;
    extraConfig = ''
      [SpamFilter]
      spam_tag = spam 
      [KillThreadsFilter]
      [ListMailsFilter]
      [ArchiveSentMailsFilter]
      sent_tag = sent
      [InboxFilter]
    '';
  };
}
