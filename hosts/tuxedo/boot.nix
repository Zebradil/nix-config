{ pkgs, ... }:
{
  hardware.cpu.amd.updateMicrocode = true;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  # boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  boot = {
    initrd = {
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "thunderbolt"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ "kvm-amd" ];
    };
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
