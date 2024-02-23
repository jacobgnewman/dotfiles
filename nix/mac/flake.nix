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

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs;
        [ 
          git
          neofetch
          neovim
          vim 
        ];

      # broken?
      homebrew = {
        enable = true;
        onActivation.cleanup = "uninstall";
        taps = [];
        brews = [ ];
        casks = [ 
        "binary-ninja"
        "kiwix"
        "kicad"
        "saleae-logic"
        "tunnelblick"
        "talon"
        "obs"
        ];
      };

      users.users.gray = {
        name = "gray";
        home = "/Users/gray";
        shell = pkgs.fish;
        packages = with pkgs; [
          
          # Project management
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
          nmap
          ripgrep
          rsync
          tmux
          wget
          zoxide

          # --------- code/utils --------- 
          binutils
          dprint   # formatting for strange files 
          helix
          llvm
          nixd
          # python
          python3

          # rust
          rustup

          typst

          # latex
          tectonic # build system 
          texlab   # lsp

          opam
          qemu

          # --------- Applications --------- 
          alacritty
          discord
          inkscape
          obsidian
          raycast
          sioyek  # pdf viewer
          spotify
          tailscale
          utm
          wireshark
          vscode
        ];
      };

      fonts = {
        fontDir.enable = true;
        fonts = with pkgs;[ dejavu_fonts jetbrains-mono ];
      };

      
      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

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
          ShowPathbar= true;
          ShowStatusBar = true;
        };
      };

      # 
      programs.fish.enable = true;
      programs.zsh.enable = true;  # default shell on catalina
      environment.shells = with pkgs; [ fish zsh ];
      # $ chsh -s /run/current-system/sw/bin/fish

      security.pam.enableSudoTouchIdAuth = true;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.config.allowUnfree = true;
    };

    # home-mangaer config
    homeconfig = {pkgs, ...}: {

      home.stateVersion = "23.05";
      # let home-manager install & manage itself
      programs.home-manager.enable = true;

      programs.fish = {
        enable = true;
        shellAliases = {
          drs = "darwin-rebuild switch --flake ~/dotfiles/nix/mac";
        };
      };

      programs.zsh = {
        enable = true;
        shellAliases = {
          drs = "darwin-rebuild switch --flake ~/dotfiles/nix/mac";
        };
      };

      home.sessionVariables = {
        EDITOR = "vim";
      };

      programs.git = {
        enable = true;
        userName = "jacobgnewman";
        userEmail = "57055451+jacobgnewman@users.noreply.github.com";
        ignores = [ ".DS_Store" ];
        extraConfig = {
          init.defaultBranch = "main";
          push.autoSetupRemote = true;
        };
      };

      programs.tmux = {
        enable = true;
        keyMode = "vi";
        mouse = true;
        shell = "/run/current-system/sw/bin/fish";
        terminal = "xterm-256color";
        extraConfig = ''
          set -as terminal-overrides ",alacritty*:Tc"
          unbind C-b
          set-option -g prefix C-a
          bind-key C-a send-prefix


          # vim binds to navigate panes
          bind h select-pane -L
          bind j select-pane -D
          bind k select-pane -U
          bind l select-pane -R

          # rebind splits
          bind | split-window -h
          bind - split-window -v
          unbind '"'
          unbind %

          # hot-reload helper
          bind r source-file ~/.tmux.conf
        '';
      };
      
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#MBP
    darwinConfigurations."MBP" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        home-manager.darwinModules.home-manager  {
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
