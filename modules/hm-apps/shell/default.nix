{ self, ... }:
{
  flake.homeModules.shell = {
    imports = with self.homeModules; [
      bash
      zsh
    ];
  };
}
