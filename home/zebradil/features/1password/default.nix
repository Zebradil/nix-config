{
  pkgs,
  lib,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    _1password-gui
    _1password-cli
  ];

  home.persistence = {
    "/persist".directories = [ ".config/1Password" ];
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
    '';
  };

  programs.git = {
    extraConfig = {
      gpg.format = "ssh";
      "gpg \"ssh\"" = {
        program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };

      user.signingKey = config.sshPublicKey.content;
    };
  };
}
