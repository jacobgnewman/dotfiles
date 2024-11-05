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
    ../../roles/terminal
  ];

  # run builds on badger to speed up builds and conserve *FAN NOISE*
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

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # System Time & localization
  # `timedatectl list-timezones` or `timedatectl set-timezone C`
  # time.timeZone = "America/Vancouver";
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
      wifi.backend = "iwd"; # seems broken on UBC wifi :(
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

  services.gnome.gnome-keyring.enable = true;

  environment.sessionVariables = {
    EDITOR = "nvim";
  };

  services.emacs = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    # toybox
    # School networking
    openconnect_openssl

    # profiling workloads
    # linuxPackages_latest.perf # profiler
    # flamegraph # chart generator
    # hotspot # gui
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
