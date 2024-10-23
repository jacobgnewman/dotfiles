{
  config,
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./framework.nix
    ../../users/gray.nix
    ../../roles/ctf
    ../../roles/desktop
    ../../roles/dev
    ../../roles/general
  ];

  nix = {
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "badger";
        system = "x86_64-linux";
        maxJobs = 100;
        supportedFeatures = ["benchmark" "big-parallel"];
      }
    ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # System Time & localization
  # `timedatectl list-timezones` or `timedatectl set-timezone C`
  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # networking settings
  networking = {
    hostName = "fern";
    wireless.userControlled.enable = true;
    networkmanager = {
      # wifi.backend = "iwd"; # seems broken on UBC wifi :(
      enable = true;
      unmanaged = ["tailscale0"];
    };
  };

  # stop boot from delaying for no reason...
  systemd.services.NetworkManager-wait-online.enable = false;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  programs.nix-ld.enable = true;

  # user shell things
  programs.fish.enable = true;

  services.gnome.gnome-keyring.enable = true;

  environment.sessionVariables = {
    EDITOR = "nvim";
  };

  services.emacs = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    # School networking
    openconnect_openssl

    # profiling workloads
    linuxPackages_latest.perf # profiler
    flamegraph # chart generator
    hotspot # gui

    # fish
    fishPlugins.done
    fishPlugins.pure
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fishPlugins.z
    fishPlugins.grc
    grc

    # UGH
    p7zip

    # Terminal utilities
    coreutils
    dust # better graphical du
    lazydocker # TUI for docker stuff
    fzf # fuzzy finder
    fd # nice find alternative with better defaults
    google-cloud-sdk # GCP TUI controller
    impala
    jq # cmdline json parser
    jujutsu # git compat VCS
    kubectl # kubernetes CLI
    llvmPackages.bintools # binary utilities
    ncspot
    openvpn # VPN util
    postgresql
    ripgrep # fast grep
    wl-clipboard # clipboard cli interface
    wineWowPackages.unstableFull # wine emulation layer for windows bin's
    zoxide # improved z

    # Programming Language Lib's & Stuff
  ];

  fonts.packages = with pkgs; [
    alegreya
    font-awesome
    jetbrains-mono
    (nerdfonts.override {fonts = ["FiraCode"];})
    departure-mono
    # (import ./../../pkgs/lilex)
  ];

  services.syncthing = {
    enable = true;
    user = "gray";
    dataDir = "/home/gray/";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  programs.steam = {
    enable = true;
  };

  services.printing.enable = true;

  security.sudo.wheelNeedsPassword = false;

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = ["gray"];

  programs.firefox.enable = true;

  programs.ssh.startAgent = true;
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.tailscale.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}
