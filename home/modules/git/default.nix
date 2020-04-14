{ ... }:
let
  secrets = import ../../../secrets.nix;
in {
  programs.git = {
    enable = true;
    userName = "Harry Freeborough";
    userEmail = secrets.email;
    signing = {
      key = "7BAC3284F76546D2";
      signByDefault = true;
    };
  };
}
