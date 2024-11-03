{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../users/gray.nix
    ../../roles/ctf
    ../../roles/desktop
    ../../roles/dev
    ../../roles/general
    ../../roles/terminal
  ];

  # nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Clear /tmp
  boot.tmp.cleanOnBoot = true;
  # faster dbus
  services.dbus.implementation = "broker";
  # faster rebuild-switch
  system.switch = {
    enable = false;
    enableNg = true;
  };

  # System Time & localization
  # `timedatectl list-timezones` or `timedatectl set-timezone C`
  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # networking settings
  networking.hostName = "badger"; # Define your hostname.
  networking.networkmanager.enable = true;

  security.sudo.wheelNeedsPassword = false;
  programs.nix-ld.enable = true;

  programs.ssh.startAgent = true;

  environment.systemPackages = with pkgs; [
    # tests
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  programs.steam = {
    enable = true;
  };

  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;

  programs.firefox.enable = true;


  # Services

  services.jellyfin.enable = true;

  services.openssh.enable = true;

  services.syncthing = {
    enable = true;
    user = "gray";
    dataDir = "/home/gray/";
  };

  services.tailscale.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
