{ config, lib, pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix
    ../../common
  ];

  networking.hostName = "harrogate";
  networking.wireless.enable = true;

  home-manager.users.harry = { ... }: {
    imports = [ ../../home ];

    me.i3.background = ../../home/modules/i3/background/earth_at_night_1366x768.png;
  };
}
