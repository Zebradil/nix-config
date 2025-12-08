{ ... }:
{
  imports = [
    ./base.nix
  ];

  # Optimization for SD cards (do not compress the image, faster build)
  sdImage.compressImage = false;

  services.mediamtx = {
    enable = true;
    settings = {
      paths = {
        cam = "/cam";
        source = "rpiCamera";
        # 720p is the sweet spot for Pi Zero 2 W WiFi latency
        rpiCameraWidth = 1280;
        rpiCameraHeight = 720;
        rpiCameraFPS = 30;
        # 2Mbps bitrate ensures smooth streaming over wireless
        rpiCameraBitrate = 2000000;
        # Use the GPU to encode, saving your CPU
        rpiCameraCodec = "hardwareH264";
        rpiCameraTuningFile = "";
      };
    };
  };
}
