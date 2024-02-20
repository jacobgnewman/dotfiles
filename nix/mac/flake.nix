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
        casks = [ "kiwix" ];
      };

      users.users.gray = {
        name = "gray";
        home = "/Users/gray";
        shell = pkgs.fish;
        packages = with pkgs; [];
        
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

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.fish.enable = true;
      programs.zsh.enable = true;  # default shell on catalina

      security.pam.enableSudoTouchIdAuth = true;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      # nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.hostPlatform = "x86_64-darwin";
      nixpkgs.config.allowUnfree = true;

    };
    # home-mangaer config
    homeconfig = {pkgs, ...}: {

      home.stateVersion = "23.05";
      # let home-manager install & manage itself
      programs.home-manager.enable = true;

      

      home.packages = with pkgs; [

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
        rust-analyzer
        typst

        # latex
        tectonic # build system 
        texlab   # lsp

        opam
        qemu

        # --------- Applications --------- 

        # alacritty
        # inkscape
        # raycast
      ];

      programs.fish = {
        enable = true;
        shellAliases = {
          drs = "darwin-rebuild switch --flake ~/dotfiles/nix/mac";
        };
      };

      # programs.zsh = {
      #   enable = true;
      #   shellAliases = {
      #     drs = "darwin-rebuild switch --flake ~/dotfiles/nix/mac";
      #   };
      # };

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

      # programs.tmux = {
      #   enable = true;
      #   keyMode = "vi";
      # };
      
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
