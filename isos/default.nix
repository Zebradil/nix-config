{ pkgs, inputs, ... }:
let
  generator = inputs.nixos-generators.nixosGenerate;
  system = pkgs.stdenv.hostPlatform.system;
in
{
  install-iso = generator {
    inherit system;
    modules = [ ./modules/install.nix ];
    format = "install-iso";
  };
}
// pkgs.lib.optionalAttrs (system == "aarch64-linux") {
  # Generic Raspberry Pi image
  rpi-sd-image = generator {
    inherit system;
    modules = [ ./modules/rpi.nix ];
    format = "sd-aarch64";
  };
  # Raspberry Pi image with mediamtx
  rpi-mediamtx-image = generator {
    inherit system;
    modules = [ ./modules/rpi-mediamtx.nix ];
    format = "sd-aarch64";
  };
}
