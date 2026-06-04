{ self, ... }:
let
  username = "yanis";
in
{
  flake.nixosModules."${username}" = {
    users.users."${username}" = {
      isNormalUser = true;
      home = "/home/${username}";
      description = "Yanis Mammar";
      extraGroups = [
        "wheel"
        "networkmanager"
        "dialout"
      ];
    };
  };

  flake.homeModules."${username}" = { config, ... }: {
    home.username = username;
    home.homeDirectory = "/home/${config.home.username}";

    programs.git.settings = {
      user.name = self.lib.obfuscate "nezayay";
      user.email = self.lib.obfuscate "zyx.rammam@sinay";
    };
  };
}
