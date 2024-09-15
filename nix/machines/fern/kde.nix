{pkgs, ...}: {

  services.desktopManager.plasma6.enable = true;

  # why is screen sharing hard
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-kde
      xdg-desktop-portal-wlr
    ];
  };

  # exclude kde apps
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    oxygen
    kate
    elisa
    gwenview
    okular
  ];

  environment.systemPackages = with pkgs.kdePackages; [
    filelight
  ];


}
