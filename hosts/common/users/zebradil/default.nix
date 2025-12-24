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
      "docker"
      "git"
      "i2c"
      "libvirtd"
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
    hashedPasswordFile = config.sops.secrets.password.path;
    packages = [ pkgs.home-manager ];
  };

  sops.defaultSopsFile = ./secrets.yaml;

  sops.secrets.password = {
    neededForUsers = true;
  };

  home-manager.users.zebradil = import ../../../../home/zebradil/${config.networking.hostName}.nix;

  sops.secrets."u2f_keys/${config.networking.hostName}" = {
    path = "/home/zebradil/.config/Yubico/u2f_keys";
    owner = "zebradil";
    mode = "0400";
  };

  security.pam.services = {
    swaylock = { };
    hyprlock = { };
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
}
