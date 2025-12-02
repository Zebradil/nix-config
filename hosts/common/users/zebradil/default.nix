{
  pkgs,
  config,
  lib,
  ...
}:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.mutableUsers = false;
  users.users.zebradil = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = ifTheyExist [
      "audio"
      "deluge"
      "docker"
      "git"
      "i2c"
      "libvirtd"
      "minecraft"
      "mysql"
      "network"
      "plugdev"
      "podman"
      "tss"
      "video"
      "wheel"
      "wireshark"
    ];

    openssh.authorizedKeys.keys = lib.splitString "\n" (
      builtins.readFile ../../../../home/zebradil/ssh.pub
    );
    hashedPasswordFile = config.sops.secrets.zebradil-password.path;
    packages = [ pkgs.home-manager ];
  };

  sops.secrets.zebradil-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  home-manager.users.zebradil = import ../../../../home/zebradil/${config.networking.hostName}.nix;

  security.pam.services = {
    swaylock = { };
    hyprlock = { };
  };
}
