{
  config,
  pkgs,
  pkgs-stable,
  ...
}: {

  imports = [
    ./hardware-configuration.nix
    # ./sway.nix # old desktop
    ./kde.nix # 
    ./framework.nix
    ../../users/gray.nix
    ../../roles/ctf
  ];


  # nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix = {
    distributedBuilds = true;
    buildMachines = [
      { hostName = "badger";
        system = "x86_64-linux";
        maxJobs = 100;
        supportedFeatures = [ "benchmark" "big-parallel" ];
      }
    ];
  };

  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Clear /tmp 
  boot.tmp.cleanOnBoot = true;
  # faster dbus
  services.dbus.implementation = "broker";
  # faster rebuild-switch
  system.switch = {
    enable = false;
    enableNg = true;
  };

  # System Time & localization
  # `timedatectl list-timezones` or `timedatectl set-timezone C`
  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

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
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # networking settings
  networking = {
    hostName = "fern";
    wireless.userControlled.enable = true;
    networkmanager = {
      wifi.backend = "iwd"; # seems broken on UBC wifi :(
      enable = true;
      unmanaged = ["tailscale0"];
    };
  };
  # stop boot from delaying for no reason...
  systemd.services.NetworkManager-wait-online.enable = false;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  programs.nix-ld.enable = true;


  # user shell things
  programs.fish.enable = true;
  programs.xonsh.enable = true;
  users.users.gray.shell = pkgs.fish;


  programs.ssh.startAgent = true;

  # environment.sessionVariables = {
  #   EDITOR = "nvim";
  # };

  services.emacs = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    # GUI Apps
    alacritty               # terminal emulator
    anki                    # spaced repition
    blender                 # 3d modeling
    chromium                # terrible browser
    gimp                    # Image editor
    halloy                  # IRC client
    inkscape                # Vector graphics
    krita                   # oss painting platform
    neovide                 # neovim gui
    obsidian                # note taking
    obs-studio              # screen recording & streaming
    pkgs-stable.kicad-small # PCB design
    prusa-slicer            # 3D model Slicer
    sioyek                  # pdf viewer
    thunderbird             # email client
    vesktop                 # discord client wayland
    vscode.fhs              # Vscode editor unwrapped?
    zed-editor              # zed, faster version of ^

    # bahished zone
    zoom-us
    
    # School networking
    openconnect_openssl

    # profiling workloads
    linuxPackages_latest.perf # profiler
    flamegraph # chart generator
    hotspot # gui


    # fish
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fishPlugins.z
    fishPlugins.grc
    grc

    # UGH
    p7zip

    # Terminal utilities
    coreutils
    dust                        # better graphical du
    lazydocker                  # TUI for docker stuff
    fzf                         # fuzzy finder
    fd                          # nice find alternative with better defaults
    google-cloud-sdk            # GCP TUI controller
    jq                          # cmdline json parser
    jujutsu                     # git compat VCS
    kubectl                     # kubernetes CLI
    llvmPackages.bintools       # binary utilities
    openvpn                     # VPN util
    postgresql 
    ripgrep                     # fast grep
    wl-clipboard                # clipboard cli interface
    # wineWowPackages.waylandFull # wine emulation layer for windows bin's
    wineWowPackages.unstableFull # wine emulation layer for windows bin's
    zoxide                      # improved z


    # Programming Language Lib's & Stuff

    # C & Friends
    gcc
    llvm
    clang

    # Debugger tools
    rr

    # Erlang
    erlang
    erlang-ls

    # Haskell
    # haskell.compiler.ghc910
    ghc
    haskell-language-server
    cabal-install

    # Latex
    tectonic
    
    # Prolog
    swiProlog

    # Python
    python312Full
    python312Packages.pip

    # Racket
    racket

    # Rust
    # rustup

    # Sagemath
    pkgs-stable.sage

    # Typst
    typst
    
    # sw libraries
    ffmpeg
    gmp
    gmpxx
    libclang
    mold # faster linker
    mold-wrapped
    pkg-config
    zlib
  ];

  

  fonts.packages = with pkgs; [
    alegreya
    font-awesome
    fira-code
    fira-code-symbols
    jetbrains-mono
    nerdfonts
    departure-mono
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  programs.steam = {
    enable = true;
  };

  services.printing.enable = true;

  security.sudo.wheelNeedsPassword = false;

  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = ["gray"];
  
  

  programs.firefox.enable = true;

  services.openssh.enable = true;
  services.tailscale.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}
