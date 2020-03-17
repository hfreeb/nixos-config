# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    #rev = "0d1ca254d0f213a118459c5be8ae465018132f74";
    #ref = "release-19.09";
    rev = "cc386e4b3b3dbb6fb5d02e657afeacf218911d96";
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "harrysnix"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
  environment.systemPackages = with pkgs; [
    wget brave termite git neovim
  ];

  programs.fish.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  services.xserver = {
    enable = true;
    layout = "gb";
    xkbOptions = "caps:swapescape";
    libinput.enable = true;
    displayManager.startx.enable = true;
    displayManager.defaultSession = "none+i3";
    desktopManager.xterm.enable = false;
    windowManager.i3.enable = true;
  };

  users.groups.nix = {};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.harry = {
    isNormalUser = true;
    extraGroups = [ "wheel" "nix" ]; # Enable ‘sudo’ for the user.
    shell = "/run/current-system/sw/bin/fish";
  };

  home-manager.users.harry = import ./home.nix;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}

