{ pkgs, lib, ... }:
{
  imports = [
    ./fish
    ./git
    ./i3
    ./nvim
    ./termite
  ];

  home.packages = with pkgs; [
    cmatrix
    sl
    maim
    feh
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "termite";
  };
}
