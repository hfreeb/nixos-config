{ pkgs, lib, ... }:
{
  imports = [
    ./modules/fish
    ./modules/git
    ./modules/i3
    ./modules/nvim
    ./modules/termite
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
