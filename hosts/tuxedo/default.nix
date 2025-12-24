{ ... }:
{
  imports = [
    ./boot.nix
    ./disko.nix
    ./laptop.nix
    ./hardware-configuration.nix

    ../common/global
    ../common/users/zebradil
    ../common/gui

    # ../common/optional/peripherals.nix
    # ../common/optional/pipewire.nix
    ../common/optional/quietboot.nix

    ../common/optional/wireless.nix
    # ../common/optional/secure-boot.nix
  ];

  networking = {
    hostName = "tuxedo";
  };

  system.stateVersion = "22.05";
}
