_: {
  flake.homeModules.gandi =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      glabRootDir = "${config.home.homeDirectory}/dev/gitlab.corp.gandi.net";

      machineDirs = map (s: glabRootDir + "/ops/sysops" + s) [
        "/puppet/enc"
        "/puppet-7/enc"
        "/hosting-puppet/enc"
      ];
    in
    {
      home.shellAliases = {
        gssh = ''
          print -z -- ssh root@$(find ${lib.concatStringsSep " " machineDirs} \
            ! -type d \
            -name "*0x35.net.yaml" \
            -exec basename -s .yaml -a {} + \
          | ${pkgs.fzf}/bin/fzf \
            --reverse \
            --prompt="connect to SSH server > " \
            --preview "[ -n '{}' ] && ${pkgs.fping}/bin/fping {}" \
            --bind "tab:preview([ -n '{}' ] && ${pkgs.fping}/bin/fping -c 10 {})" 
          )
        '';
      };

      programs.ssh.settings = {
        "Host *" = {
          ForwardAgent = false;
          AddKeysToAgent = "no";
          Compression = false;
          ServerAliveInterval = 0;
          ServerAliveCountMax = 3;
          HashKnownHosts = false;
          UserKnownHostsFile = "~/.ssh/known_hosts";
          ControlMaster = "no";
          ControlPath = "~/.ssh/master-%r@%n:%p";
          ControlPersist = "no";
          PubkeyAcceptedKeyTypes = "+ssh-rsa";
        };
      };
    };
}
