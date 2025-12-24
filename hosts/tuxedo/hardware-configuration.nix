{ inputs, ... }:
{
  imports = [
    inputs.hardware.nixosModules.tuxedo-infinitybook-pro14-gen9-amd
    ../common/optional/ephemeral-btrfs.nix
  ];

  nixpkgs.hostPlatform.system = "x86_64-linux";
}
