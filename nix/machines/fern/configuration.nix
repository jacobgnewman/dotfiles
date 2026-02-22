# Help: configuration.nix(5) man page, https://search.nixos.org/options and `nixos-help`

{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # language support
    ../../roles/dev
    ../../roles/terminal
    ../../users/gray.nix

    # TODO move to flake!?!?
    (
      builtins.fetchTarball {
        url = "https://github.com/nix-community/disko/archive/master.tar.gz";
        sha256 = "89m5VKxIs8QNiIvLsxHu5NpyhDsoXTtoN801IAurnW4=";
      }
      + "/module.nix"
    )
    (import ./disk-config.nix { zpoolName = "rpool"; })

  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostId = "9f521a2b"; # TODO document generation :P
  networking.hostName = "fern"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # nix settings
  nix.package = pkgs.lixPackageSets.stable.lix;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # TODO! move desktop setup to something more *fun*
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the GNOME Desktop Environment
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;


  virtualisation.docker = {
    enable = true;
  };



  environment.localBinInPath = true;
  environment.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    TERMINAL = "ghostty";
  };

  environment.systemPackages = with pkgs; [
    # editors
    helix
    neovim

    ghostty

    google-chrome

    atuin
    wget
    git
    gh
    qemu
    obsidian
  ];

  fonts.packages = with pkgs; [
    maple-mono.NF-unhinted
    alegreya
  ];

  # PROGRAMS

  programs.firefox.enable = true;
 
  # nh
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/gray/dotfiles/nix/machines/fern";
  };

  programs.steam = {
    enable = true;
  };

  # nice shell history, requires adding line to ~/.zshrc
  services.atuin.enable = true;

  # :)
  services.tailscale = {
    enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.11"; # Did you read the comment?
}
