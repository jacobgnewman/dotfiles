{pkgs, ...}: {
  # Sway configuration

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    xwayland.enable = true;
  };

  # file browser
  programs.yazi = {
    enable = true;
  };

  # let user modify brightness & volume
  users.users.gray.extraGroups = ["video"];
  programs.light.enable = true;

  # let gnome-keyring manage secrets
  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    #wayland/sway utils

    slurp # selection window
    grim # screenshot
    wl-clipboard # clipboard cli interface
    xdg-desktop-portal # screen sharing?
    xdg-desktop-portal-wlr # screen sharing?
    brightnessctl # modify display brightness
    waybar # top bar config
    wf-recorder # screen recording
  ];
}
