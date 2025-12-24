{ pkgs, ... }:
{
  programs.hyprland.enable = true;
  # Optional, hint electron apps to use wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = [
    # ... other packages
    pkgs.kitty # required for the default Hyprland config
  ];
}
