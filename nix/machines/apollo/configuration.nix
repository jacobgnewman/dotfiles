{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../rpi4.nix
  ];

  networking.hostName = "apollo";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  users.users.gray = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    packages = with pkgs; [
      git
      gh
      wget
      tree
    ];
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDOlBcrO5Tyq8ESc6uavW7Lnq4IWEC+YyG5KIAfn7r85"];
  };
  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  # system.copySystemConfiguration = true;
  system.stateVersion = "23.11";
}
