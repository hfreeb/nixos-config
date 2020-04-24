{ ... }:
let secrets = import ../../secrets.nix;
in {
  programs.git = {
    enable = true;
    userName = "Harry Freeborough";
    userEmail = secrets.email;
    signing = {
      key = "691EF7EF51D10E69";
      signByDefault = true;
    };
  };
}
