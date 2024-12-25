{
  outputs = inputs @ {nixpkgs, ...}: let
    user = import ./user;

    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  in {
    packages = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in (user.packages pkgs)
    );
    # Formatter for your nix files, available through 'nix fmt'
    formatter = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        pkgs.alejandra
    );

    nixosModules =
      {
        # This module is not meant to be imported by anyone but me
        # it's just so I can easily avoid ../../../../../ mess
        system = import ./system;

        user = user.module;
      }
      // import ./modules;

    nixosConfigurations = import ./hosts inputs;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
}
