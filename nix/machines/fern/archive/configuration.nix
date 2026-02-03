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
  # nix = {
  #   distributedBuilds = true;
  #   buildMachines = [
  #     {
  #       hostName = "badger";
  #       system = "x86_64-linux";
  #       maxJobs = 100;
  #       supportedFeatures = ["benchmark" "big-parallel"];
  #     }
  #   ];
  # };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # System Time & localization
  # `timedatectl list-timezones` or `timedatectl set-timezone C`
  # time.timeZone = "America/Vancouver";
  time.timeZone = "Asia/Seoul";

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

    # wireless.iwd.package = pkgs-stable.iwd;

    wireless.iwd.settings = {
      IPv6 = {
        Enabled = true;
      };
      Settings = {
        AutoConnect = true;
      };
    };
  };

  programs.niri.enable = true;
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/gray/dotfiles/nix/machines/fern/"; # sets NH_OS_FLAKE variable for you
  };

  # stop boot from delaying for no reason...
  systemd.services.NetworkManager-wait-online.enable = false;

  networking.firewall.allowedTCPPorts = [8765];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    #package = pkgs-stable.bluez;
  };

  programs.nix-ld.enable = true;

  services.gnome.gnome-keyring.enable = true;

  environment.sessionVariables = {
    EDITOR = "nvim";
  };

  environment.systemPackages = with pkgs; [
    # School networking
    # openconnect_openssl
  ];

  services.syncthing = {
    enable = true;
    user = "gray";
    dataDir = "/home/gray/";
  };

  # hardware.graphics = {
  #   enable = true;
  #   enable32Bit = true;
  # };
  programs.steam = {
    enable = true;
  };

  security.sudo.wheelNeedsPassword = false;

  virtualisation.docker.enable = true;
  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  # users.extraGroups.vboxusers.members = ["gray"];

  programs.firefox.enable = true;

  #programs.ssh.startAgent = true;
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
