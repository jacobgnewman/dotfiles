{
  config,
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./sway.nix # desktop
    ./kde.nix
    ./framework.nix
    ../../users/gray.nix
    ../../roles/ctf
  ];

  # nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
  boot.kernelModules = [
    "v4l2loopback"
  ];

  # networking settings
  networking = {
    hostName = "fern";

    wireless.userControlled.enable = true;
    networkmanager = {
      enable = true;
      unmanaged = ["tailscale0"];
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  programs.nix-ld.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  services.power-profiles-daemon.enable = true;

  programs.fish.enable = true;
  users.users.gray.shell = pkgs.fish;

  # gnome
  services.gvfs.enable = true;

  programs.ssh.startAgent = true;

  services.ollama.enable = true;

  environment.systemPackages = with pkgs; [
    # general applications
    alacritty # terminal emulator
    anki # spaced repition
    blender # 3d modeling
    gimp
    inkscape # Vector graphics
    pkgs-stable.kicad-small # PCB design
    obsidian # note taking
    obs-studio # screen recording / streaming
    prusa-slicer
    seahorse # keyring
    sioyek # pdf viewer
    vesktop # discord client wayland
    vscode.fhs

    ncspot

    # networking
    openvpn

    # profiling workloads
    linuxPackages_latest.perf # profiler
    flamegraph # chart generator
    hotspot # gui

    chromium

    wineWowPackages.waylandFull

    # fish
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fishPlugins.grc
    # ( import ../../packages/fish-zoxide.nix {})
    grc

    # Term stuff
    ffmpegthumbnailer
    unar
    jq
    poppler
    fd
    ripgrep
    fzf
    zoxide
    zellij
    # ueberzugpp

    # sw dev
    gcc
    gmp
    gmpxx
    avra
    avrdude
    llvm
    libclang
    llvmPackages.bintools
    mold
    mold-wrapped
    pkgs-stable.sage
    clang
    gmp
    google-cloud-sdk
    rustup
  ];

  fonts.packages = with pkgs; [
    font-awesome
    fira-code
    fira-code-symbols
    jetbrains-mono
    nerdfonts
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

  # services.automatic-timezoned.enable = true;
  # time.timeZone = "America/Vancouver";
  # `timedatectl list-timezones` or `timedatectl set-timezone C`
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
