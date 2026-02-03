{pkgs, ...}: {
  # Framework Specific config details

  # Wifi Card, amd model requires domain settings for MAX SPEED
  hardware.wirelessRegulatoryDatabase = true;
  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom="US"
  '';

  environment.systemPackages = with pkgs; [
    # easyeffects # app to install audio config
  ];

  hardware.sensor.iio.enable = true;

  # Set powermode of cpu
  services.power-profiles-daemon.enable = true;

  # fingerprint sensor
  services.fprintd.enable = true;

  # firmware updates
  services.fwupd.enable = true;
}
