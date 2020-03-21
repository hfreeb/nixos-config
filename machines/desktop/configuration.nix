{ config, lib, pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix
    ../../common
    ../../common/pci-passthrough.nix
  ];

  networking.hostName = "halifax";
  networking.useDHCP = false;
  networking.interfaces.enp3s0.useDHCP = true;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [ minecraft ];
  services.xserver.videoDrivers = [ "nvidia" ];

  home-manager.users.harry = { ... }: {
    imports = [ ../../home ];

    me.i3 = {
      background = ../../home/modules/i3/background/earth_at_night_1920x1080.png;
      monitorAssigns = {
        "1" = "DVI-D-1";
        "2" = "DVI-I-1";
        "3" = "DVI-D-1";
        "4" = "DVI-I-1";
      };
    };
  };

  pciPassthrough = {
    # enable = true;
    pciIDs = "10de:13c2,10de:0fbb";
    inputDevices = [
      "/dev/input/by-id/usb-Logitech_USB_Receiver-if02-event-mouse"
      "/dev/input/by-id/usb-Razer_Razer_DeathStalker-event-kbd"
    ];
    libvirtUsers = [ "harry" ];
  };
}
