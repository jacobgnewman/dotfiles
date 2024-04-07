{...}: {
  imports = [
    <nixos-hardware/raspberry-pi/4>
  ];

  hardware = {
    raspberry-pi."4".apply-overlays-dtmerge.enable = true;
    raspberry-pi."4".poe-hat.enable = true;
  };
  # Use the extlinux boot loader.
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";

  networking.networkmanager.enable = true; # Easiest to use and most distros use this by defaul
  services.openssh.enable = true;
  services.tailscale.enable = true;
}
