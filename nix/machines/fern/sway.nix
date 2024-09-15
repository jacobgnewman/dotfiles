{pkgs, ...}: {
  # Sway configuration

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    xwayland.enable = true;
    extraSessionCommands = ''
    '';
  };


  # file browser
  programs.yazi = {
    enable = true;
  };

  # let user modify brightness & volume
  users.users.gray.extraGroups = ["video"];
  programs.light.enable = true;

  xdg.portal = {
    wlr = {
      enable = true;
      settings = {
        screencast = {
          output_name = "eDP-1";
          max_fps = 30;
          chooser_type = "simple";
          chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
        };
      };
    };
  };

  # sway specific packages
  environment.systemPackages = with pkgs; [
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
