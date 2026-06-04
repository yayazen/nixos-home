_: {
  flake.homeModules.email = {
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
    };
  };
}
