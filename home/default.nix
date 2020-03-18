{ pkgs, lib, ... }:
{
  imports = [
    ./modules/fish
    ./modules/git
    ./modules/i3
    ./modules/nvim
    ./modules/termite
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    cmatrix
    sl
    maim
    feh
    weechat
    discord
    jetbrains.idea-ultimate
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "termite";
  };
}
