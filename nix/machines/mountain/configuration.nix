{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../users/gray.nix
    ../../roles/terminal
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "mountain"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";

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

  # -------- SERVICES ---------

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user="gray";
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.syncthing = {
    enable = true;
    user = "gray";
    guiAddress = "100.81.65.124:8384";
    dataDir = "/home/gray/sync"; # Default folder for new synced folders
    configDir = "/home/gray/.config/syncthing"; # Folder for Syncthing's settings and keys
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    extraUpFlags = [
      "--ssh"
    ];
  };

  services.vaultwarden.enable = true;

  # security.acme = {
  #   acceptTerms = true;
  #   defaults = {
  #     email = "acme@mountainrose.ca";
  #     dnsProvider = "cloudflare";
  #     environmentFile = "/var/lib/secrets/cloudflare.env";
  #   };
  # };

  # users.users.nginx.extraGroups = ["acme"];
  # services.nginx = {
  #   enable = true;

  #   # Use recommended settings
  #   recommendedGzipSettings = true;

  #   virtualHosts."vaultwarden.mountainrose.ca" = {
  #     enableACME = true;
  #     acmeRoot = null;
  #     forceSSL = true;
  #     locations."/" = {
  #       proxyPass = "http://127.0.0.1:8000";
  #     };
  #   };
  # };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "23.11"; # Did you read the comment?
}
