{
  lib,
  ...
}:
let
  # Function to safely get env vars (returns "" if not set)
  # Requires passing '--impure' to the build command
  getEnv = name: builtins.getEnv name;

  wifiSsid = getEnv "ISO_WIFI_SSID";
  wifiPass = getEnv "ISO_WIFI_PASS";
in
{
  config = lib.mkMerge [
    # Inject WiFi configuration from environment variables
    (lib.mkIf (wifiSsid != "" && wifiPass != "") {
      networking.networkmanager.ensureProfiles.profiles."EnvWiFi" = {
        connection = {
          id = "EnvWiFi";
          type = "wifi";
        };
        wifi = {
          ssid = wifiSsid;
        };
        wifi-security = {
          key-mgmt = "wpa-psk";
          psk = wifiPass;
        };
      };
    })
  ];
}
