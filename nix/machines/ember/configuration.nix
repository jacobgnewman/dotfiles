{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    <nixos-hardware/raspberry-pi/4>
    ./hardware-configuration.nix
  ];

  hardware = {
    raspberry-pi."4".apply-overlays-dtmerge.enable = true;
    raspberry-pi."4".poe-hat.enable = true;
  };

  # Use the extlinux boot loader.
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "ember"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by defaul

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  i18n.defaultLocale = "en_CA.UTF-8";

  users.users.gray = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      git
      gh
      wget
      tree
    ];
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDOlBcrO5Tyq8ESc6uavW7Lnq4IWEC+YyG5KIAfn7r85"];
  };

  security.sudo.wheelNeedsPassword = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
  ];

  services.openssh.enable = true;
  services.tailscale.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
