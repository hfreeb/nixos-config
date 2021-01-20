{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
  ];

  networking.hostName = "harrogate";

  networking.wireless.enable = true;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  home-manager = {
    useGlobalPkgs = true;

    users.harry = { ... }: {
      imports = [ ../../home ];

      hfreeb.graphical.background =
        ../../home/i3/background/earth_at_night_1366x768.png;
    };
  };
}
