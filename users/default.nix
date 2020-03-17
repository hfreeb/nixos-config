{ config, pkgs, ... }:
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "cc386e4b3b3dbb6fb5d02e657afeacf218911d96";
  };
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  users.users.harry = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = "/run/current-system/sw/bin/fish";
  };

  home-manager.users.harry = import ../home;
}
