{ pkgs, ... }:
let unstable = import (builtins.fetchGit {
    url = "https://github.com/NixOS/nixpkgs-channels.git";
    rev = "fce7562cf46727fdaf801b232116bc9ce0512049"; # 2020-05-01
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
