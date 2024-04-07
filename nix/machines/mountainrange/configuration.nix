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
    ../../services/syncthing.nix
    ../../users/gray.nix
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

  services.ollama.enable = true;

  services.openssh.enable = true;
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    extraUpFlags = [
      "--ssh"
      "--advertise-routes=192.168.0.0/24"
    ];
  };

  services.vaultwarden.enable = true;

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "acme@mountainrose.ca";
      dnsProvider = "cloudflare";
      environmentFile = "/var/lib/secrets/cloudflare.env";
    };
  };

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
  };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "23.11"; # Did you read the comment?
}
