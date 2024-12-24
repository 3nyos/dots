{
  config,
  pkgs,
  ...
}: let
  inherit (builtins) attrValues;
in {
  environment.systemPackages = attrValues {
    inherit
      (pkgs)
      foot
      wl-clipboard
      zsh-nix-shell
      ;
  };

  fonts = {
    packages =
      attrValues {
        inherit
          (pkgs)
          ;
      }
      ++ [
        pkgs.nerd-fonts.jetbrains-mono
      ];

    enableDefaultPackages = false;
  };
}
