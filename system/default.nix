{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./net
    ./hardware
    ./audio
    ./users
    ./wayland
    ./nix
  ];

  time = {
    timeZone = "America/Montevideo";
    hardwareClockInLocalTime = true;
  };
}
