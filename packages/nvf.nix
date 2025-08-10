{
  vim = {
    theme = {
      enable = true;
      name = "gruvbox";
      style = "dark";
    };

    options = {
      tabstop = 2;
      shiftwidth = 2;
    };

    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    navigation.harpoon.enable = true;

    lsp.enable = true;
    languages = {
      enableTreesitter = true;
      enableFormat = true;
      nix = {
        enable = true;
        format.enable = true;
        format.type = "nixfmt";
      };
      bash.enable = true;
      yaml.enable = true;
      clang.enable = true;
    };
  };
}
