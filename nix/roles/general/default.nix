{
  #pkgs,
  ...
}: {
  # General random NixOS settings that should be applied to all machines

  # nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Clear /tmp
  boot.tmp.cleanOnBoot = true;
  # faster dbus
  services.dbus.implementation = "broker";
  # faster rebuild-switch
  system.switch = {
    enable = false;
  };
}
