{pkgs, ...}: {
  # Sway configuration

  programs.niri = {
    enable = true;
  };

  # let user modify brightness & volume
  users.users.gray.extraGroups = ["video"];
  programs.light.enable = true;

  # sway specific packages
  environment.systemPackages = with pkgs; [
    fuzzel # application launcher
    colord # manage color profiles TODO! fix?
    slurp # selection window
    grim # screenshot
    wl-clipboard # clipboard cli interface
    brightnessctl # modify display brightness
    waybar # top bar config
    wf-recorder # screen recording
    mako # notification daemon
    pwvucontrol # volume control
    coppwr # audio routing
  ];

  # Required ENV variables for Sway to play nice with apps
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # electron & chromium wayland
  };

  environment.variables = {
    _JAVA_AWT_WM_NONREPARENTING = 1; # java gui apps
  };
}
