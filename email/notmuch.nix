{ config, pkgs, ... }:
{
  programs.notmuch = {
    enable = true;
    new = {
      tags = [
        "new" # used by afew
      ];
    };
    search.excludeTags = [
      "deleted"
      "spam"
      "junk"
    ];
    hooks = {
      preNew = ''
        #        notmuch search --output=files --format=text0 tag:killed | xargs -r0 rm
        #        notmuch new 
      '';
    };
  };
}
