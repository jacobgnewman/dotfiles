{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../services/homepage.nix
    ../../services/forgejo.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "mountainrange"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";

  users.users.gray = {
    isNormalUser = true;
    description = "gray";
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      alejandra
      direnv
      git
      gh
      lazygit
      helix
      python3
      tmux
      unzip
      binutils
      gdb
      pwndbg
      nil
    ];
  };

  environment.variables = {
    COLORTERM = "truecolor";
  };

  # save some typing :)
  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    nginx
    vim
    wget
    zfs
  ];

  programs.nix-ld.enable = true;
  programs.direnv.enable = true;

  virtualisation.docker.enable = true;

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "acme@mountainrose.ca";
      dnsProvider = "cloudflare";
      environmentFile = "/var/lib/secrets/cloudflare.env";
    };
  };

  # -------- SERVICES ---------

  services.openssh.enable = true;
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
    extraUpFlags = [
      "--ssh"
      "--advertise-routes=192.168.0.0/24"
    ];
  };

  services = {
    forgejo = {
      enable = true;
      settings.server.DOMAIN = "git.mountainrose";
      settings.server.HTTP_PORT = 3000;
    };

    syncthing = {
      enable = true;
      user = "gray";
      guiAddress = "127.0.0.1:8384";
      dataDir = "/home/gray/sync"; # Default folder for new synced folders
      configDir = "/home/gray/.config/syncthing"; # Folder for Syncthing's settings and keys
    };
  };

  services.vaultwarden.enable = true;

  users.users.nginx.extraGroups = ["acme"];
  services.nginx = {
    enable = true;

    # Use recommended settings
    recommendedGzipSettings = true;

    virtualHosts."vaultwarden.mountainrose.ca" = {
      enableACME = true;
      acmeRoot = null;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8000";
      };
    };

    virtualHosts."syncthing.mountainrose.ca" = {
      enableACME = true;
      acmeRoot = null;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8384";
      };
    };

    # Forgejo Service
    virtualHosts."git.mountainrose.ca" = {
      enableACME = true;
      acmeRoot = null;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
      };
    };

    # Homepage Service
    virtualHosts."mountainrose.ca" = {
      enableACME = true;
      acmeRoot = null;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8082";
      };
    };
  };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "23.11"; # Did you read the comment?
}
