{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    grub2
    pkgsCross.i686-embedded.buildPackages.gcc
  ];
}
