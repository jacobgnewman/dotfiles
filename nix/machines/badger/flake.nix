{
  description = "Flake for badger box";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixpkgs-stable = {
      url = "github:NixOS/nixpkgs/nixos-24.05";
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0-rc1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    lix-module,
  }: {
    nixosConfigurations = {
      badger = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        
        # pass non-default nixpkgs to other modules
        specialArgs = {
          pkgs-stable = import nixpkgs-stable {
            inherit system; # rec
            config.allowUnfree = true;
          };
        };

        modules = [
          ./configuration.nix
          lix-module.nixosModules.default
        ];
      };
    };
  };
}
