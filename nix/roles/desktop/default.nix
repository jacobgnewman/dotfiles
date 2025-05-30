{pkgs, ...}: {
  # Desktop Environment
  imports = [
    ./kde.nix
    ./niri.nix
  ];

  # Login Manager
  services.xserver.enable = true; # x11
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd startplasma-wayland";
        user = "greeter";
      };
    };
  };

  # Audio Config
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Desktop Applications

  environment.systemPackages = with pkgs; [
    # GUI Apps
    alacritty # terminal emulator
    ghostty
    anki # spaced repition
    # blender # 3d modeling
    chromium # terrible browser
    discord
    dolphin-emu
    gimp # Image editor
    ghostty # new terminal editor
    halloy # IRC client
    inkscape # Vector graphics
    krita # oss painting platform
    neovide # neovim gui
    obsidian # note taking
    obs-studio # screen recording & streaming
    kicad-small # PCB design
    prusa-slicer # 3D model Slicer
    saleae-logic-2 # aaaa
    sioyek # pdf viewer
    thunderbird # email client
    vesktop # discord client wayland
    vscode.fhs # Vscode editor unwrapped?
    vlc
    #zed-editor # zed, faster version of ^
  ];

  fonts.packages = with pkgs; [
    alegreya
    font-awesome
    jetbrains-mono
    nerd-fonts.lilex
    departure-mono
    # (import ./../../pkgs/lilex)
  ];
}
