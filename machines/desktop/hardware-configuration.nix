{ lib, ... }:

{
  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/eeb8e045-3535-409d-bd0e-3eb983c0fcc5";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1A77-2835";
      fsType = "vfat";
    };

  fileSystems."/mnt/d" = {
    device = "/dev/disk/by-uuid/4AE4DF5AE4DF46BB";
    fsType = "ntfs";
    options = [ "rw" "uid=1000" ];
  };

  fileSystems."/mnt/one" = {
    device = "/dev/disk/by-uuid/B46CA7006CA6BD0C";
    fsType = "ntfs";
    options = [ "rw" "uid=1000" ];
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/9b1d152b-32cc-4b7b-afbb-1fd44f4ff794"; }];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
