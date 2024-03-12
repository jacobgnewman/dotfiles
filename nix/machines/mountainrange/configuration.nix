{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Nix Stuff
  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "mountainrange"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gray = {
    isNormalUser = true;
    description = "gray";
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      alejandra
      direnv
      git
      gh
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
  services.tailscale.enable = true;

  services = {
    forgejo = {
      enable = true;
    };

    homepage-dashboard = {
      enable = true;
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

    virtualHosts."bitwarden.mountainrose.ca" = {
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
