{...}: {

  staypls = {
    enable = true;
    dirs = [
      "/etc/ssh"
      "/etc/NetworkManager/system-connections"
      "/etc/nix"
      "/var/lib/pipewire"
      "/etc/passwd"
      "/etc/nixos"
      "/var/db/sudo"
      "/etc/shadow"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/log"
    ];
  };

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    # if you need more than 1GB for root then
    # you are doing something wrong
    options = ["size=1G" "mode=755"];
  };

  fileSystems."/nix" = {
    neededForBoot = true;
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "btrfs";
    options = ["noatime" "subvol=nix"];
  };

  fileSystems."/tmp" = {
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "btrfs";
    options = ["noatime" "subvol=tmp"];
  };

  fileSystems."/persist" = {
    neededForBoot = true;
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "btrfs";
    options = ["noatime" "subvol=persist"];
  };

  fileSystems."/home" = {
    neededForBoot = true;
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "btrfs";
    options = ["noatime" "subvol=home"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXBOOT";
    fsType = "vfat";
    options = ["noatime"];
  };

  swapDevices = [];

}
