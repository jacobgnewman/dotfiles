{pkgs, ...}: {
  services.desktopManager.plasma6.enable = true;
  # services.displayManager.defaultSession = "plasmax11";

  # why is screen sharing hard
  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = "*";
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
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

  environment.systemPackages = with pkgs; [
    kdePackages.filelight
    wl-clipboard # clipboard cli interface
  ];
}
