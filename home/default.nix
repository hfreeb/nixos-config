{ pkgs, ... }:
let unstable = import <nixos-unstable> { config.allowUnfree = true; };
in {
  imports = [
    ./fish
    ./git
    ./i3
    ./dunst
    ./nvim
    ./termite
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    cmatrix
    sl
    weechat
    discord
    unstable.jetbrains.idea-ultimate
    unstable.jetbrains.clion
    pulsemixer
    gimp
    neofetch
    zathura
    feh
    maim
    xclip
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "termite";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = let
      browser = "firefox.desktop";
    in {
      "text/html" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "application/pdf" = "zathura";
    };
  };
}
