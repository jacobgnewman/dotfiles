{
  description = "dusk system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, lix-module }:
  let
    configuration = { pkgs, ... }: {

      imports = [
      	../../roles/terminal
      ];

      nix.settings.experimental-features = "nix-command flakes";
      nixpkgs.config.allowUnfree = true;
      nixpkgs.hostPlatform = "aarch64-darwin";

      # manage the nix daemon
      services.nix-daemon.enable = true;

      networking.hostName = "dusk";

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [ 
          neovim
          git
          gh
          just
          tmux
          # applications
          # anki
          alacritty
          imhex
          # sioyek
          obsidian


          # dev
          # rust
          rustup

          # python
          python313

          # nix
          alejandra
          nil

          # prolog
          swi-prolog
      ];

      fonts.packages = with pkgs; [
          alegreya
          nerdfonts
          departure-mono
      ];

      services.tailscale.enable = true;

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Jacobs-MacBook-Pro
    darwinConfigurations."dusk" = nix-darwin.lib.darwinSystem {
      modules = [
        lix-module.nixosModules.default
        configuration
      ];
    };

    darwinPackages = self.darwinConfigurations."dusk".pkgs;
  };
}
