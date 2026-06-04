{ self, ... }: {
  flake.homeModules.nvim =
    { pkgs, ... }:
    {
      home.packages = [
        self.packages.${pkgs.stdenv.system}.nvim
      ];

      home.sessionVariables = {
        EDITOR = "vim";
      };
    };
}
