{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.nvim =
        (inputs.nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [
            ./_nvf.nix
          ];
        }).neovim;
    };
}
