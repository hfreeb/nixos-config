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
      pandas
      pylint
      scipy
    ]);
  in with pkgs; [
    archiver
    binutils
    chromium
    file
    firefox
    gcc
    gdb
    git
    git-crypt
    gnumake
    go
    golint
    gotools
    grub2
    hwinfo
    lastpass-cli
    mypy
    nasm
    neovim
    nmap
    nodejs
    openconnect_pa
    openjdk11
    openjdk8
    pciutils
    pkgsCross.i686-embedded.buildPackages.gcc
    qemu
    ranger
    termite
    tree
    wget
    xorriso
  ];

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
