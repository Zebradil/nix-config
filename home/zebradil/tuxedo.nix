{ pkgs, ... }:
{
  imports = [
    ./global
    ./features/desktop/hyprland
    ./features/desktop/wireless
    # ./features/productivity
    ./features/1password
    # ./features/games
  ];

  # Purple
  wallpaper = pkgs.inputs.themes.wallpapers.deer-lunar-fantasy;

  monitors = [
    {
      name = "eDP-1";
      width = 2880;
      height = 1800;
      workspace = "1";
      primary = true;
      refreshRate = 60; # It can do 120
      scale = 2.0;
    }
  ];
}
