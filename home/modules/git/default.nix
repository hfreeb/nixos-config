{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "hfreeb";
    userEmail = "harry@hfreeb.com";
    signing = {
      key = "7BAC3284F76546D2";
      signByDefault = true;
    };
  };
}
