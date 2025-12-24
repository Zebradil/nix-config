{ pkgs, ... }:
{
  powerManagement.powertop.enable = true;
  powerManagement.cpuFreqGovernor = "perfomance";

  programs.light.enable = true;
  environment.systemPackages = [ pkgs.brightnessctl ];

  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
    powerKey = "suspend";
    powerKeyLongPress = "poweroff";
  };

  hardware.graphics.enable = true;
}
