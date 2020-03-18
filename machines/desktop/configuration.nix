{ config, lib, pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix
    ../../common
  ];

  networking.hostName = "halifax";
  networking.useDHCP = false;
  networking.interfaces.enp3s0.useDHCP = true;

  home-manager.users.harry = { ... }: {
    imports = [ ../../home ];

    me.i3.background = ../../home/modules/i3/background/earth_at_night_1920x1080.png;
  };
}