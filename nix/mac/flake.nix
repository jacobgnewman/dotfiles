{
  description = "MacOS Nix-darwin config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
  }: let
    configuration = {pkgs, ...}: {
      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget

      # system packages
      environment.systemPackages = with pkgs; [
        # --------- Terminal Utils ---------
        git
        neofetch
        neovim
        vim

        # --------- Applications ---------
        # For *some* apps to show up in /Applications they must be added here...
        alacritty
        discord
        inkscape
        obsidian
        sioyek # pdf viewer
        tailscale
        utm
        wireshark
        vscode
      ];

      # broken?
      homebrew = {
        enable = true;
        onActivation.cleanup = "uninstall";
        taps = [
          "homebrew/cask-versions"
        ];
        brews = [];
        casks = [
          "binary-ninja"
          "firefox-developer-edition"
          "kiwix"
          "kicad"
          "raycast"
          "saleae-logic"
          "spotify"
          "tunnelblick"
          "talon"
          "obs"
          "vlc"
          "zed"
        ];
      };

      users.users.gray = {
        name = "gray";
        home = "/Users/gray";
        shell = pkgs.fish;
        packages = with pkgs; [
          # --------- Project management ---------
          direnv
          nix-direnv
          # --------- Terminal Utils ---------
          bat
          btop
          eza
          fzf
          gh
          git-lfs
          jq
          lazygit
          mold
          nmap
          ripgrep
          rsync
          tmux
          wget
          zoxide
          # --------- code/utils ---------
          alejandra # nix code formatter
          binutils
          dprint # formatting for strange files
          helix
          llvm
          nil
          marksman
          python3
          rustup
          typst
          tectonic # latex build system
          texlab # latex lsp
          opam
          qemu
        ];
      };

      fonts = {
        fontDir.enable = true;
        fonts = with pkgs; [
          jetbrains-mono
        ];
      };

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # system settings
      system.defaults = {
        dock = {
          autohide = true;
          mru-spaces = false; # don't rearrange spaces baset on most recently used
          show-recents = false;
        };

        finder = {
          AppleShowAllExtensions = true;
          FXEnableExtensionChangeWarning = false;
          ShowPathbar = true;
          ShowStatusBar = true;
        };

        NSGlobalDomain = {
          AppleShowAllExtensions = true;
          ApplePressAndHoldEnabled = false;

          # 120, 90, 60, 30, 12, 6, 2
          KeyRepeat = 120;

          # 120, 94, 68, 35, 25, 15
          InitialKeyRepeat = 15;

          "com.apple.mouse.tapBehavior" = 1;
          "com.apple.sound.beep.volume" = 0.0;
          "com.apple.sound.beep.feedback" = 0;
        };
      };

      system.keyboard = {
        enableKeyMapping = true;
        remapCapsLockToControl = true;
      };

      # To set fish as proper shell
      # $ chsh -s /run/current-system/sw/bin/fish
      programs.fish.enable = true;
      programs.zsh.enable = true; # default shell on catalina
      environment.shells = with pkgs; [fish zsh];

      security.pam.enableSudoTouchIdAuth = true;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;
    };

    # home-mangaer config
    homeconfig = {pkgs, ...}: {
      home.stateVersion = "23.05";

      # let home-manager install & manage itself
      programs.home-manager.enable = true;

      home.sessionVariables = {
        EDITOR = "vim";
      };

      programs.git = {
        enable = true;
        userName = "jacobgnewman";
        userEmail = "57055451+jacobgnewman@users.noreply.github.com";
        ignores = [".DS_Store"];
        extraConfig = {
          init.defaultBranch = "main";
          push.autoSetupRemote = true;
        };
      };
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#MBP
    darwinConfigurations."Jacobs-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.verbose = true;
          home-manager.users.gray = homeconfig;
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."MBP".pkgs;
  };
}
