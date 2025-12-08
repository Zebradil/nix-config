{ pkgs, ... }:
{
  imports = [
    ./impure.nix # Enables configuration via environment vars with --impure
    ../../hosts/common/global/fish.nix
  ];

  networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  users.users.root.openssh.authorizedKeys.keys = [
    (builtins.readFile ../ssh_root_ed25519_key.pub)
  ];

  users.users.root.shell = pkgs.fish;

  environment.systemPackages = with pkgs; [
    bottom
    curl
    git
    htop
    neofetch
    neovim
    tmux
    wget
  ];

  system.stateVersion = "25.11";
}
