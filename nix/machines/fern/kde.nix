{pkgs, ...}: {

  services.desktopManager.plasma6.enable = true;

  # exclude kde apps
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    # plasma-browser-integration
    konsole
    oxygen
  ];

}
