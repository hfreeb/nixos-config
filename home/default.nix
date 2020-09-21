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
    cmatrix
    feh
    ghidra-bin
    gimp
    jwhois
    keepassxc
    libreoffice
    maim
    neofetch
    pulsemixer
    texlive.combined.scheme-basic
    unstable._1password-gui
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
