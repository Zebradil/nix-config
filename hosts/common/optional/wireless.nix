{
  config,
  lib,
  ...
}:
let
  homeWiFis = [
    "DUST"
    "DUSTY"
    "DUSK"
  ];
in
{
  hardware.bluetooth = {
    enable = true;
  };

  sops.secrets.wireless = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };

  networking.wireless = {
    enable = true;
    fallbackToWPA2 = false;
    # Declarative
    secretsFile = config.sops.secrets.wireless.path;
    networks = lib.genAttrs homeWiFis (_ssid: {
      pskRaw = "ext:psk_home";
    });

    # Imperative
    allowAuxiliaryImperativeNetworks = true;
    # https://discourse.nixos.org/t/is-networking-usercontrolled-working-with-wpa-gui-for-anyone/29659
    extraConfig = ''
      ctrl_interface=DIR=/run/wpa_supplicant GROUP=${config.users.groups.network.name}
      update_config=1
    '';
  };

  # Ensure group exists
  users.groups.network = { };

  systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
}
