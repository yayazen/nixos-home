{ ... }:
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

  flake.homeModules."${username}" = {
    home.username = username;
    home.homeDirectory = "/home/${username}";
  };
}
