{
  description = "Flake test, v2alpha";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    user = import ./user;
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    filter = path: type: let
      fileName = baseNameOf path;
    in
      !(builtins.hasSuffix ".nix" fileName || fileName == "flake.lock");
  in {
    packages = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in (user.packages pkgs
      // {
        src = builtins.filterSource filter ./.;
      }));
    formatter = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in
      pkgs.alejandra);
    nixosModules =
      {
        system = import ./system;
        user = user.module;
      }
      // import ./modules;
    nixosConfigurations = import ./hosts inputs;
  };
}
