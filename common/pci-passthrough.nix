
{config, pkgs, lib, ... }:

with lib;
let
  cfg = config.pciPassthrough;
in
{
  options.pciPassthrough = {
    enable = mkEnableOption "PCI Passthrough";

    cpuType = mkOption {
      description = "One of `intel` or `amd`";
      default = "intel";
      type = types.str;
    };

    pciIDs = mkOption {
      description = "Comma-separated list of PCI IDs to pass-through";
      type = types.str;
    };

    libvirtUsers = mkOption {
      description = "Extra users to add to libvirtd (root is already included)";
      type = types.listOf types.str;
      default = [];
    };

    inputDevices = mkOption { 
      type = types.listOf types.str;
      default = [];
      example = [ "/dev/input/by-id/kbd-event" "/dev/input/by-id/mouse-event" ];
      description = ''
        Input devices to add to the QEMU cgroup device ACL.
        This is needed to passthrough evdev events to the guest.
      '';
    };
  };

  config = (mkIf cfg.enable {

    boot.kernelParams = [ "${cfg.cpuType}_iommu=on" "iommu=pt" ];

    # These modules are required for PCI passthrough, and must come before early modesetting stuff
    boot.kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ];

    boot.extraModprobeConfig ="options vfio-pci ids=${cfg.pciIDs}";

    environment.systemPackages = with pkgs; [
      virtmanager
      qemu
      OVMF
      pciutils
    ];

    programs.dconf.enable = true;

    virtualisation.libvirtd = {
      enable = true;
      qemuOvmf = true;
      qemuRunAsRoot = false;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemuPackage = pkgs.qemu_kvm;
    };

    users.groups.libvirt.members = [ "root" ] ++ cfg.libvirtUsers;
    users.groups.libvirtd.members = [ "root" ] ++ cfg.libvirtUsers;
    users.groups.qemu-libvirtd.members = [ "root" ] ++ cfg.libvirtUsers;
    users.groups.input.members = [ "root" "qemu-libvirtd" ] ++ cfg.libvirtUsers;

    virtualisation.libvirtd.qemuVerbatimConfig = ''
      nvram = [
      "${pkgs.OVMF}/FV/OVMF.fd:${pkgs.OVMF}/FV/OVMF_VARS.fd"
      ]
      cgroup_device_acl = [
          "/dev/null",
          "/dev/full",
          "/dev/zero",
          "/dev/random",
          "/dev/urandom",
          "/dev/ptmx",
          "/dev/kvm",
          "/dev/kqemu",
          "/dev/rtc",
          "/dev/hpet",
          ${concatStringsSep ",\n" (map (x: ''"${x}"'') cfg.inputDevices)}
      ]
      namespaces = []
    '';
  });
}
