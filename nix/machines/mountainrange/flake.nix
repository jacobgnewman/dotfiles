{
  description = "Mountainrange Flake; Internal Big boi";
  inputs = {
    # nixpkgs = {
    #   url = "github:NixOS/nixpkgs/nixos-unstable";
    # };
    lix = {
      url = "git+ssh://git@git.lix.systems/lix-project/lix";
      flake = false;
    };
    lix-module = {
      url = "git+ssh://git@git.lix.systems/lix-project/nixos-module";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix.follows = "lix";
    };
  };

  outputs = {
    self,
    nixpkgs,
    lix-module,
    lix,
    ...
  }: {
    nixosConfigurations = {
      mountainrange = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          lix-module.nixosModules.default
        ];
      };
    };
  };
}
