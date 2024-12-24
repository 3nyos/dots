{
  config,
  pkgs,
  ...
}: {
  networking = {
    networkmanager.enable = true;
    enableIPv6 = true;
    useDHCP = lib.mkDefault true;
  };
  systemd.services.NetworkManager-wait-online.enable = false;
}
