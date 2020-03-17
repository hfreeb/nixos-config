{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    cmatrix sl maim
  ];

  imports = [
    ./fish
    ./git
    ./i3
    ./nvim
    ./termite
  ];
}
