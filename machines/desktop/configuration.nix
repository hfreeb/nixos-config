{ pkgs, lib, ... }:
{
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix
    ../../common
  ];

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r rpool/local/root@blank
  '';

  environment.etc."nixos/configuration.nix".source= "/persist/etc/nixos/machines/desktop/configuration.nix";

  networking.hostId = "45a9c894";
  networking.hostName = "halifax";
  networking.useDHCP = false;
  networking.interfaces.enp3s0.useDHCP = true;

  nixpkgs.config.allowUnfree = true;
  services.xserver= {
    videoDrivers = [ "nvidia" ];
    xrandrHeads = [
      { output = "DVI-I-1"; primary = true; }
      "DVI-D-0"
    ];
  };

  home-manager.users.harry = { ... }: {
    imports = [ ../../home ];
    home.packages = with pkgs; [
      minecraft
      runelite
      (writeShellScriptBin "archive"
        "${pkgs.coreutils}/bin/cp -i -v --target-directory=/mnt/two/archive/other/ $@")
    ];

    hfreeb.graphical = {
      background = ../../home/i3/background/nixos_nord.png;
      wm.i3.monitorAssigns = {
        "1" = "DVI-D-1";
        "2" = "DVI-I-1";
        "3" = "DVI-D-1";
        "4" = "DVI-I-1";
      };
    };
  };
}
