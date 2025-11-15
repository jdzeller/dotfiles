{
  description = "My first flake!";
 
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # use the following for unstable:
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        gopher = lib.nixosSystem {
          system = "aarch64-linux";
          modules = [ ./configuration.nix ];
      };
    };
  };
}
