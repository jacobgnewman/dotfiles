{
  config,
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./sway.nix # desktop
    ../../users/gray.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
  boot.kernelModules = [
    "v4l2loopback"
  ];

  # nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Framework stuff, supposedly improves wifi speed?
  hardware.wirelessRegulatoryDatabase = true;
  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom="CA"
  '';

  systemd.services.NetworkManager-wait-online.enable = false;

  # desktop config
  services.xserver.enable = true; # x11
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  programs.nix-ld.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    # general applications
    alacritty
    pkgs-stable.kicad-small
    obsidian
    obs-studio
    podman-desktop
    sioyek
    vesktop

    chromium

    wineWowPackages.waylandFull

    # Term stuff
    ffmpegthumbnailer
    unar
    jq
    poppler
    fd
    ripgrep
    fzf
    zoxide
    ueberzugpp

    # CTF
    nmap
    # binwalk
    wireshark
    ghidra
    pkgs-stable.imhex

    # sw dev
    avra
    avrdude
    llvm
    libclang
    gmp
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    font-awesome
    fira-code
    fira-code-symbols
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  programs.steam = {
    enable = true;
  };

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

  networking.hostName = "fern";
  networking.networkmanager = {
    enable = true;
    unmanaged = ["tailscale0"];
  };

  # services.automatic-timezoned.enable = true;
  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  security.sudo.wheelNeedsPassword = false;

  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;

  programs.firefox.enable = true;

  services.openssh.enable = true;
  services.tailscale.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}
