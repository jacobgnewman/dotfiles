{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.fern = nixpkgs.lib.nixosSystem {
      modules = [ ./configuration.nix ];
    };
  };
}

