{
  description = "Fern Flake";
  inputs = {
    nixpkgs = {
    #   url = "github:NixOS/nixpkgs/nixos-unstable";
    # };
    # nixpkgs-stable = {
      url = "github:NixOS/nixpkgs/nixos-24.11";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-2.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    # nixpkgs-stable,
    lix-module,
  }: {
    nixosConfigurations = {
      fern = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";

        # pass non-default nixpkgs to other modules
        # specialArgs = {
        #   pkgs-stable = import nixpkgs-stable {
        #     inherit system; # rec
        #     config.allowUnfree = true;
        #   };
        # };

        modules = [
          ./configuration.nix
          lix-module.nixosModules.default
        ];
      };
    };
  };
}
