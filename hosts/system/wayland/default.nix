{
  config,
  pkgs,
  ...
}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.variables = {
    NIXOS_OZONE_WL = 1;
  };
}
