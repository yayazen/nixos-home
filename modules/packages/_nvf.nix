{ pkgs, ... }:
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

    extraPlugins = with pkgs.vimPlugins; {
      claudecode = {
        package = claudecode-nvim;
        setup = "require('claudecode').setup {}";
      };
    };

    lsp.enable = true;
    languages = {
      enableTreesitter = true;
      enableFormat = true;
      nix = {
        enable = true;
        format.enable = true;
        format.type = [ "nixfmt" ];
      };
      bash.enable = true;
      yaml.enable = true;
      clang.enable = true;
      haskell.enable = true;
      markdown = {
        enable = true;
        extensions = {
          markview-nvim.enable = true;
        };
      };
    };

    luaConfigPost = ''
      vim.api.nvim_create_user_command('CodeTemplateBash', function()
        local template = [[
      #!/usr/bin/env bash
        
      set -o nounset            # Fail on use of unset variable.
      set -o errexit            # Exit on command failure.
      set -o pipefail           # Exit on failure of any command in a pipeline.
      set -o errtrace           # Trap errors in functions and subshells.
      shopt -s inherit_errexit  # Inherit the errexit option status in subshells.

      # Print a useful trace when an error occurs
      trap 'echo Error when executing ''${BASH_COMMAND} at line ''${LINENO}! >&2' ERR
      ]]
        
        local lines = vim.split(template, '\n', { plain = true })
        vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
      end, {})
    '';
  };
}
