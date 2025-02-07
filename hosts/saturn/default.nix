{
  config,
  pkgs,
  modulesPath,
  lib,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  services.fstrim.enable = true;
  hardware.amdgpu.initrd.enable = true;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  hardware.graphics.extraPackages = builtins.attrValues {
    inherit
      (pkgs)
      amdvlk
      mesa
      ;
  };

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      grub = {
        devices = ["nodev"];
        efiSupport = true;
        enable = true;

        extraEntries = ''
          menuentry "Win 11" {
            insmod part_gpt
            insmod fat
            insmod search_fs_uuid
            insmod chain
            search --fs-uuid --set=root F2FA-6537
            chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          }
        '';
      };
    };

    kernelModules = ["amdgpu"]; # if loading somehow fails during initrd but the boot continues, try again later
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
