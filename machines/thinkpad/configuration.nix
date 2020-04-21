{ ... }:
{
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix
    ../../common
  ];

  networking.hostName = "harrogate";
  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;
  networking.wireless.enable = true;

  home-manager.users.harry = { ... }: {
    imports = [ ../../home ];

    hfreeb.graphical.background =
      ../../home/i3/background/earth_at_night_1366x768.png;
  };
}
