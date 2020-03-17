{ config, lib, pkgs, ... }:
{
  imports = [
    <nixos-hardware/lenovo/thinkpad>
    <nixos-hardware/lenovo/thinkpad/tp-smapi.nix>
    <nixos-hardware/common/cpu/intel/sandy-bridge>
    <nixos-hardware/common/pc/ssd>
  ];

  hardware.enableRedistributableFirmware = lib.mkDefault true;

  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "xhci_pci" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/55aed4ae-6a18-4d3d-af37-6f31ef760851";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4BCA-4D77";
    fsType = "vfat";
  };

  swapDevices = [{
    device = "/dev/disk/by-uuid/25107bc1-85d4-439f-808b-c4595065a617";
  }];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
