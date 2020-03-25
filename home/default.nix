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
    weechat
    discord
    jetbrains.idea-ultimate
    pulsemixer
    nmap
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "termite";
  };
}
