{ pkgs, ... }:
let
  python3WithPackages = pkgs.python3.withPackages(p: with p; [
    (opencv4.override(old: { enableGtk2 = true; }))
    compiledb
    jedi
    jupyterlab
    matplotlib
    numpy
    pandas
    pylint
    scipy
  ]);
in
{
  imports = [
    ./boot
    ./display
    ./networking
    ./nix
    ./users
  ];

  nixpkgs.overlays = [
    (import ../overlays/updates.nix)
    (import ../overlays/fonts.nix)
  ];

  networking.useDHCP = false;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  console.font = "Lat2-Terminus16";

  programs.fish.enable = true;
  programs.gnupg.agent.enable = true;

  programs.java = {
    enable = true;
    package = pkgs.openjdk11;
  };

  environment.systemPackages = with pkgs; [
    _1password-gui
    ant
    archiver
    binutils
    cabal-install
    chromium
    cmatrix
    discord
    eclipses.eclipse-java
    exif
    feh
    feh
    file
    firefox
    gcc
    gdb
    ghc
    ghidra-bin
    gimp
    git
    git-crypt
    gnumake
    go
    gobuster
    golint
    gotools
    hwinfo
    imagemagick7
    jetbrains.clion
    jetbrains.idea-ultimate
    john
    jwhois
    keepassxc
    ktlint
    libgit2
    libnotify
    libreoffice
    maim
    nasm
    neofetch
    neovim
    nmap
    nodejs
    openconnect_pa
    openvpn
    pciutils
    php
    pulsemixer
    python3WithPackages
    qemu
    ranger
    rethinkdb
    spotify
    teams
    termite
    texlive.combined.scheme-full
    tree
    vlc
    vscode
    weechat
    wget
    wireshark
    xclip
    xorriso
    zathura
    zoom-us
  ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03";
}
