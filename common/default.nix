{ config, lib, pkgs, ... }:
{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.nameservers = [ "9.9.9.9" "149.112.112.112" ];
  # Generate read-only resolv.conf to stop dhcpcd overwriting it.
  environment.etc."resolv.conf".text = ''
    ${lib.concatStringsSep "\n" (map (ns: "nameserver ${ns}") config.networking.nameservers)}
    options edns0
  '';

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  console = {
    font= "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  nixpkgs.config = {
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

  fonts.fonts = with pkgs; [
    font-awesome iosevka-term
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = let
    mypy = pkgs.python3.withPackages(p: with p; [
      pylint
      jedi
      numpy
      jupyterlab
      scipy
      matplotlib
      pandas
    ]);
  in with pkgs; [
    wget
    firefox
    chromium
    termite
    git
    ranger
    hwinfo
    pciutils
    go
    gotools
    golint
    nodejs
    mypy
    neovim
  ];

  programs.gnupg.agent.enable = true;

  programs.fish.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver = {
    enable = true;
    layout = "gb";
    xkbOptions = "caps:swapescape";
    libinput = {
      enable = true;
      middleEmulation = false;
      accelProfile = "flat";
      accelSpeed = "0";
    };
    displayManager.startx.enable = true;
    displayManager.defaultSession = "none+i3";
    desktopManager.xterm.enable = false;
    windowManager.i3.enable = true;
  };

  services.openvpn.servers = {
    c = {
      config = '' config /etc/nixos/openvpn/c.ovpn '';
      autoStart = false;
    };
  };

  users.users.harry = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = "/run/current-system/sw/bin/fish";
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09";
}
