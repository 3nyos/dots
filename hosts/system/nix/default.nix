{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  nixpkgs = {
    # You can add overlays here
    overlays = [
    ];

    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      allowBroken = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      use-xdg-base-directories = true;

      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";

      accept-flake-config = false;

      use-registries = true;
      flake-registry = "";

      # use binary cache, its not gentoo
      builders-use-substitutes = true;

      # use binary cache, its not gentoo
      substituters = [
        "https://cache.nixos.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];

      # Saves disk space
      auto-optimise-store = true;

      # allow sudo users to mark the following values as trusted
      allowed-users = ["@wheel"];
      trusted-users = ["@wheel"];

      keep-derivations = true;
      keep-outputs = true;

      # i know no need to tell me
      warn-dirty = false;

      sandbox = true;
      sandbox-fallback = false;

      max-jobs = "auto";

      keep-going = false;

      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };

    # Make builds run with low priority so system stays responsive
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";

    # Opinionated: disable channels
    # channel.enable = false;

    # Disable running the garbage collector
    gc.automatic = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = ["nixpkgs=flake:nixpkgs"];
  };
}
