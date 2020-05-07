{ pkgs, ... }:
let unstable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/fce7562cf46727fdaf801b232116bc9ce0512049.tar.gz";
    sha256 = "14rvi69ji61x3z88vbn17rg5vxrnw2wbnanxb7y0qzyqrj7spapx";
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
