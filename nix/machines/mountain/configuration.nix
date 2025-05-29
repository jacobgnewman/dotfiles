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

  # head -c4 /dev/urandom | od -A none -t x4
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.forceImportRoot = false;
  boot.zfs.extraPools = ["smoldrive" "bigdrive"];
  boot.zfs.devNodes = "/dev/disk/by-id";

  networking.hostId = "4853ca31";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "mountain";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";

  environment.variables = {
    COLORTERM = "truecolor";
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    rsync
    nginx
    vim
    wget
    zfs
    yt-dlp

    # needed?
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];

  programs.nix-ld.enable = true;
  programs.direnv.enable = true;

  virtualisation.docker.enable = true;

  # -------- SERVICES ---------

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "gray";
  };

  # services.soju.enable = true;

  services.anki-sync-server = {
	  enable = true;
    users = [ 
      {
        username="gray";
        passwordFile = "/etc/nixos/anki-pw";
      }
    ];
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
    dataDir = "/home/gray/sync";
    configDir = "/home/gray/.config/syncthing";
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    extraUpFlags = [
      "--ssh"
    ];
  };

  services.nginx = {
    enable = true;
    virtualHosts.localhost = {
      locations."/" = {
        return = "200 '<html><body>It works</body></html>'";
        extraConfig = ''
          default_type text/html;
        '';
      };
      locations."/miniflux" = {
        proxyPass = "http://127.0.0.1:8080";
        extraConfig = ''
        '';
      };
      locations."/anki" = {
        proxyPass = "http://127.0.0.1:27701";
        extraConfig = ''
        '';
      };
    };
  };

  services.vaultwarden.enable = true;

  services.miniflux = {
    enable = true;
    config = {
      BASE_URL = "http://mountain.boreal-climb.ts.net/miniflux";
    };
    adminCredentialsFile = "/etc/nixos/miniflux-creds";
  };
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "23.11"; # Did you read the comment?
}
