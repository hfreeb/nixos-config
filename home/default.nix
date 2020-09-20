{ pkgs, ... }:
let unstable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/eb86bff30d874d7d65a7f7342dc81b70815a25df.tar.gz"; # 2020-09-20
    sha256 = "0s11icdlsgpa6z2gjjkw60czfcysjvy3hdxqyzn0h7kxq5b2kvla";
  }) {
    config.allowUnfree = true;
  };
in {
  imports = [
    ./dunst
    ./fish
    ./git
    ./i3
    ./nvim
    ./termite
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    (callPackage ./1password { })
    cmatrix
    feh
    gimp
    jwhois
    libreoffice
    maim
    neofetch
    pulsemixer
    texlive.combined.scheme-basic
    unstable.discord
    unstable.jetbrains.clion
    unstable.jetbrains.idea-ultimate
    vlc
    weechat
    xclip
    zathura
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
