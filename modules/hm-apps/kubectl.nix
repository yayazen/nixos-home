_: {
  flake.homeModules.kubectl =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        kubectl
      ];

      programs.k9s.enable = true;

      programs.kubecolor = {
        enable = true;
        enableAlias = true;
        enableZshIntegration = true;
      };
    };
}
