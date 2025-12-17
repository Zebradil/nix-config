{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      name = "Iosevka NFM";
      package = pkgs.nerd-fonts.iosevka;
    };
    regular = {
      name = "Fira Sans";
      package = pkgs.fira;
    };
  };
}
