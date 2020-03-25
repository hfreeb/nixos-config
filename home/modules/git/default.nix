{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Desetude";
    userEmail = "harry@desetude.com";
    signing = {
      key = "7BAC3284F76546D2";
      signByDefault = true;
    };
  };
}
