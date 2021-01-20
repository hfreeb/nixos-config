{ config, lib, pkgs, ... }:
let secrets = import ../secrets.nix;
in {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.nameservers = [ "9.9.9.9" "149.112.112.112" ];
  # Generate read-only resolv.conf to stop dhcpcd appending to it.
  environment.etc."resolv.conf".text = ''
    ${lib.concatStringsSep "\n"
    (map (ns: "nameserver ${ns}") config.networking.nameservers)}
    options edns0
  '';

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nixpkgs.overlays = [
    (import ../overlays/update.nix)
  ];

  nixpkgs.config = {
    allowUnfree = true;

    packageOverrides = super: let self = super.pkgs; in {
      iosevka-term = self.iosevka.override {
        set = "term";
        privateBuildPlan = {
          family = "Iosevka Term";
          design = [
            "term" "v-l-italic" "v-i-italic" "v-g-singlestorey"
            "v-asterisk-high" "v-at-long" "v-brace-straight"
          ];
        };
      };
    };
  };

  fonts.fonts = with pkgs; [ font-awesome iosevka-term ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = let
    mypy = pkgs.python3.withPackages(p: with p; [
      compiledb
      jedi
      jupyterlab
      matplotlib
      numpy
      (opencv4.override (old : { enableGtk2 = true; }))
      pandas
      pylint
      scipy
    ]);
  in with pkgs; [
    _1password-gui
    ant
    archiver
    binutils
    breeze-icons
    cabal-install
    chromium
    cmatrix
    discord
    eclipses.eclipse-java
    exif
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
    gnome3.adwaita-icon-theme
    gnumake
    go
    gobuster
    golint
    gotools
    gprolog
    grub2
    gtkwave
    hwinfo
    imagemagick7
    jetbrains.clion
    jetbrains.idea-ultimate
    john
    jwhois
    keepassxc
    ktlint
    lastpass-cli
    libgit2
    libreoffice
    maim
    mypy
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
    qemu
    ranger
    rethinkdb
    spotify
    swiProlog
    teams
    termite
    texlive.combined.scheme-full
    tree
    verilog
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

  programs.java = {
    enable = true;
    package = pkgs.openjdk11;
  };

  programs.gnupg.agent.enable = true;

  programs.fish.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver = {
    enable = true;
    layout = "gb";
    xkbOptions = "caps:escape";
    libinput = {
      enable = true;
      middleEmulation = false;
      accelProfile = "flat";
      accelSpeed = "0";
    };
    displayManager.startx.enable = true;
    displayManager.defaultSession = "none+i3";
    windowManager.i3.enable = true;
  };

  users.mutableUsers = false;
  users.users.root.hashedPassword = secrets.hashedPassword;
  users.users.harry = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    createHome = true;
    home = "/home/harry";
    shell = "/run/current-system/sw/bin/fish";
    hashedPassword = secrets.hashedPassword;
  };
  security.sudo.extraConfig = "Defaults lecture=never";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03";
}
