{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    cmatrix sl
  ];

  imports = [
    ./fish
    ./git
    ./i3
    ./nvim
  ];
}
