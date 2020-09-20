{ pkgs, lib, ... }:
{
  imports = [
    (import ../../home/channel.nix)
    ./hardware-configuration.nix
    ../../common
    ../../common/gaming.nix
  ];

  networking.hostId = "45a9c894";
  networking.hostName = "halifax";
  networking.useDHCP = false;
  networking.interfaces.enp3s0.useDHCP = true;

  nixpkgs.config.allowUnfree = true;
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    xrandrHeads = [
      { output = "DVI-I-1"; primary = true; }
      "DVI-D-0"
    ];
    screenSection = ''
      Option "metamodes" "DVI-I-1: nvidia-auto-select @1920x1080 +0+0 {ViewPortIn=1920x1080, ViewPortOut=1920x1080+0+0}, DVI-D-0: 1920x1080_144 @1920x1080 +1920+0 {ViewPortIn=1920x1080, ViewPortOut=1920x1080+0+0, ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
    '';
  };

  home-manager.users.harry = { ... }: {
    imports = [ ../../home ];
    home.packages = with pkgs; [
      minecraft
      runelite
      (writeShellScriptBin "archive"
        "${pkgs.coreutils}/bin/cp -i -v --target-directory=/mnt/one/archive/other/ $@")
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
