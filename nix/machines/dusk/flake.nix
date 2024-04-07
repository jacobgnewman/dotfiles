{
  description = "MacOS Nix-darwin config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nix-darwin,
    nixpkgs,
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
        ollama
        sioyek # pdf viewer
        tailscale
        utm
        wireshark
        vscode
      ];

      # broken?
      homebrew = {
        enable = true;
        onActivation = {
          autoUpdate = true;
          upgrade = true;
          cleanup = "uninstall";
        };
        taps = [
          "homebrew/cask-versions"
        ];
        brews = [
          "openjdk"
        ];
        casks = [
          "anki"
          "arduino-ide"
          "balenaetcher"
          "firefox-developer-edition"
          "kiwix"
          "kicad"
          "obs"
          "prusaslicer"
          "raycast"
          "saleae-logic"
          "spotify"
          "steam"
          "syncthing"
          "tunnelblick"
          "talon"
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
          just

          # --------- Terminal Utils ---------
          bat
          btop
          eza
          fzf
          fzf-make
          gh
          git-lfs
          jq
          lazygit
          nmap
          ripgrep
          rsync
          tmux
          tree
          wget
          zoxide

          # --------- code/utils ---------
          alejandra # nix code formatter
          binutils
          dprint # formatting for strange files
          erlang
          elixir
          elixir-ls
          helix
          llvm
          nil
          marksman
          python3
          rustup
          typst
          typst-lsp
          tectonic # latex build system
          texlab # latex lsp
          opam
          qemu
          wabt
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

      services.tailscale.enable = true;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      networking.hostName = "dusk";

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
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#MBP
    darwinConfigurations."dusk" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."dusk".pkgs;
  };
}
