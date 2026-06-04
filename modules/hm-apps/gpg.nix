{ self, ... }: {
  flake.homeModules.gpg =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      programs.gpg = {
        enable = true;
      };

      services.gpg-agent = {
        enable = true;
        enableZshIntegration = true;
        extraConfig = ''
          pinentry-program ${self.packages.${pkgs.stdenv.system}.smart-pinentry}/bin/pinentry
        '';
      };

      # Browser Pass
      programs.browserpass = {
        enable = true;
        browsers = lib.optional config.programs.firefox.enable "firefox";
      };
    };
}
