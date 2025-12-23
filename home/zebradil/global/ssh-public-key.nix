{ lib, ... }:
{
  # SSH public key configuration
  options.sshPublicKey = {
    path = lib.mkOption {
      type = lib.types.path;
      default = ../ssh.pub;
      description = "Path to SSH public key file";
    };
    content = lib.mkOption {
      type = lib.types.str;
      default = lib.strings.removeSuffix "\n" (builtins.readFile ../ssh.pub);
      description = "Content of SSH public key file";
    };
  };
}
