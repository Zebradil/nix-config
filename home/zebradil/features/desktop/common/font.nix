{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      name = "IosevkaTerm Nerd Font Mono";
      package = pkgs.nerd-fonts.iosevka;
    };
    regular = {
      name = "Fira Sans";
      package = pkgs.fira;
    };
  };
}
