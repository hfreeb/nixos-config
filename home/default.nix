{ pkgs, ... }: {
  imports = [
    ./dunst
    ./fish
    ./git
    ./i3
    ./nvim
    ./termite
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

  xdg.configFile."mimeapps.list".force = true; # Force overwrite
}
