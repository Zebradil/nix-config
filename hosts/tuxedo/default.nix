{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.tuxedo-infinitybook-pro14-gen9-amd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/zebradil

    ../common/optional/peripherals.nix
    ../common/optional/regreet.nix
    ../common/optional/pipewire.nix
    ../common/optional/quietboot.nix

    ../common/optional/wireless.nix
    # ../common/optional/secure-boot.nix
  ];

  networking = {
    hostName = "tuxedo";
  };

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;

  powerManagement.powertop.enable = true;
  programs = {
    adb.enable = true;
    dconf.enable = true;
  };

  system.stateVersion = "22.05";
}
