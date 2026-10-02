{ self, ... }:
let
  username = "yanis";
  fullname = "Yanis Mammar";
in
{
  flake.nixosModules."${username}" = {
    users.users."${username}" = {
      isNormalUser = true;
      home = "/home/${username}";
      description = fullname;
      extraGroups = [
        "wheel"
        "networkmanager"
        "dialout"
      ];
    };
  };

  flake.homeModules."${username}" =
    { config, ... }:
    {
      home.username = username;
      home.homeDirectory = "/home/${config.home.username}";

      programs.git = {
        settings = {
          user.name = self.lib.obfuscate "nezayay";
          user.email = self.lib.obfuscate "zyx.rammam@sinay";
        };
        #signing.key = "7BD1E6405C0BA03D!";
      };

      imports = with self.homeModules; [
          home-manager
          
          fonts

          lix
          nix-tools

          firefox

          kitty
          shell
          nvim
          yazi
          git
          git-custom-aliases
          gpg
          password-store
          ssh
      ];
    };
}
