{ ... }:
{
  imports = [
    ./base.nix
  ];

  # Optimization for SD cards (do not compress the image, faster build)
  sdImage.compressImage = false;

  # Avoid generating man-cache (saves time and space)
  documentation.man.generateCaches = false;
}
