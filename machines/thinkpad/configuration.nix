{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../common
  ];

  networking.hostName = "harrogate";
  networking.wireless.enable = true;
}
