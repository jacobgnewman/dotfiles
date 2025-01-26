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
    };
  };

  services.vaultwarden.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "23.11"; # Did you read the comment?
}
