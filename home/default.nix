{ pkgs, ... }: {
  imports = [
    ./dunst
    ./fish
    ./git
    ./i3
    ./nvim
    ./termite
  ];

  home.packages = with pkgs; [
    _1password-gui
    cmatrix
    discord
    feh
    ghidra-bin
    gimp
    jetbrains.clion
    jetbrains.idea-ultimate
    jwhois
    keepassxc
    libreoffice
    maim
    neofetch
    pulsemixer
    texlive.combined.scheme-basic
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
