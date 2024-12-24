rec
{
  packages = pkgs: let
    inherit (pkgs) callPackage;
  in {
  };

  module = {pkgs, ...}: {
    config = {
      environment.systemPackages = builtins.attrValues (packages pkgs);
    };
    imports = [
      ./packages.nix
      ./shell
      ./git
    ];
  };
}
