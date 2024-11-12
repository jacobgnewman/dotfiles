{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    <nixos-hardware/raspberry-pi/4>
    ./hardware-configuration.nix
    ../../users/gray.nix
  ];

  hardware = {
    raspberry-pi."4".apply-overlays-dtmerge.enable = true;
    raspberry-pi."4".poe-hat.enable = true;
  };

  # Use the extlinux boot loader.
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "ember"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  i18n.defaultLocale = "en_CA.UTF-8";

  security.sudo.wheelNeedsPassword = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    tmux
    cloudflared
  ];

  # TODO: setup properly...
  # services.cloudflared = {
  #     enable = true;
  # }

  virtualisation.docker.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.tailscale.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
