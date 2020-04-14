{ pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix
    ../../common
  ];

  me.machine = "desktop";

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
    home.packages = with pkgs; [ minecraft runelite ];

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
}
