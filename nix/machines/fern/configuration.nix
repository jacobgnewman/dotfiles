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

boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
boot.kernelModules = [
  "v4l2loopback"
];

  # Set initial kernel module settings
  # nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Framework stuff, supposed wifi speed?
  hardware.wirelessRegulatoryDatabase = true;
  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom="CA"
    # https://github.com/umlaeute/v4l2loopback
    # options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';

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

  programs.yazi = {
		enable = true;
	};

  programs.nix-ld.enable = true;


  environment.systemPackages = with pkgs; [
    alacritty
    kicad-small
    obsidian
    obs-studio
    podman-desktop
    sioyek
    vesktop

    # sway/wayland
    slurp # selection window
    grim # screenshot
    wl-clipboard # clipboard cli
    xdg-desktop-portal # screen sharing
    xdg-desktop-portal-wlr # screen sharing

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

    # desktop utils
    brightnessctl
    # sov
    waybar

    # CTF
    nmap
    binwalk
    wireshark
    ghidra
    imhex

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
  
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  networking.hostName = "fern";
  networking.networkmanager.enable = true;

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
