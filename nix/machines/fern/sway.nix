{pkgs, ...}: {
  # Sway configuration

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    xwayland.enable = true;
    extraSessionCommands = ''
    # fix Java AWT apps (Ghidra)
    export _JAVA_AWT_WM_NONREPARENTING=1
    '';
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

  # why is screen sharing hard
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
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


  environment.systemPackages = with pkgs; [
    #wayland/sway utils

    colord # manage color profiles
    slurp # selection window
    grim # screenshot
    wl-clipboard # clipboard cli interface
    brightnessctl # modify display brightness
    waybar # top bar config
    wf-recorder # screen recording
  ];

  environment.variables = {
    _JAVA_AWT_WM_NONREPARENTING = 1;
  };
}

