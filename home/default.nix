{ pkgs, ... }:
let unstable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/7f3a18d33b8159d2993484c7b35cf685bff7e4f9.tar.gz"; # 2020-08-26
    sha256 = "0ldy4swb69dfcp3m4aprqcfqbrvw4pqdlzifascilqg0jbb2hw2l";
  }) {
    config.allowUnfree = true;
  };
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
