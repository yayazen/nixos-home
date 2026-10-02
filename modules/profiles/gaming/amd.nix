{
  flake.nixosModules.gaming =
    {
      pkgs,
      lib,
      ...
    }:
    {
      boot.kernelPackages = pkgs.linuxPackages_latest;

      # CPU microcode & scaling
      #hardware.cpu.amd.updateMicrocode = true;
      #boot.kernelModules = [
      #  "kvm-amd"
      #  "amd-pstate"
      #];
      #services.xserver.videoDrivers = [ "amdgpu" ];
      powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
      boot.kernelParams = [ "amd_pstate=active" ];
      boot.initrd.kernelModules = [ "amdgpu" ];
    };
}
