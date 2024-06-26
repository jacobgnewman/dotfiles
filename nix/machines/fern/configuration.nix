{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../users/gray.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # desktop config
  services.xserver.enable = true; # x11 
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    xwayland.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    obsidian
    sioyek
    waybar
    vesktop

    # CTF
    nmap
    binwalk
    wireshark
    ghidra
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    font-awesome
  ];


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  networking.hostName = "fern";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  security.sudo.wheelNeedsPassword = false;

  virtualisation.docker.enable = true;

  programs.firefox.enable = true;

  services.openssh.enable = true;
  services.tailscale.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}
