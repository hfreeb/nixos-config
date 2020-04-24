{ lib, ... }:

{
  imports = [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "zfs" "ntfs" ];

  fileSystems."/" = {
    device = "rpool/local/root";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/1A77-2835";
    fsType = "vfat";
  };

  fileSystems."/nix" = {
    device = "rpool/local/nix";
    fsType = "zfs";
  };

  fileSystems."/home" = {
    device = "rpool/safe/home";
    fsType = "zfs";
  };

  fileSystems."/persist" = {
    device = "rpool/safe/persist";
    fsType = "zfs";
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
