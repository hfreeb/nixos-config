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
    weechat
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "termite";
  };
}
