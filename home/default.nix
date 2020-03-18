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
    cmatrix sl maim
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "termite";
  };
}
