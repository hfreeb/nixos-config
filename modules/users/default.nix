{ pkgs, ... }:
let
  secrets = import ../../secrets.nix;
in
{
  users.mutableUsers = false;

  users.users.root.hashedPassword = secrets.hashedPassword;

  users.users.harry = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    createHome = true;
    home = "/home/harry";
    shell = pkgs.fish;
    hashedPassword = secrets.hashedPassword;
  };
}
