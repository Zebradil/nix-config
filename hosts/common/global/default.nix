# This file (and the global directory) holds config that i use on all hosts
{
  inputs,
  outputs,
  ...
}:
{
  imports = [
    # ./kdeconnect.nix
    # ./podman.nix
    # ./prometheus-node-exporter.nix
    # ./tailscale.nix
    # ./tpm.nix
    ./fish.nix
    ./locale.nix
    ./nix-ld.nix
    ./nix.nix
    ./openssh.nix
    ./sops.nix
    ./systemd-initrd.nix
    ./upower.nix
  ]
  ++ (builtins.attrValues outputs.nixosModules);

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  hardware.enableRedistributableFirmware = true;
  networking.domain = "zebradil.dev";

  # Increase open file limit for sudoers
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "524288";
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = "1048576";
    }
  ];

  # Cleanup stuff included by default
  services.speechd.enable = false;
}
