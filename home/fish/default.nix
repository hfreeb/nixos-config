{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellInit = ''
      set fish_greeting
      set EDITOR nvim
    '';
    promptInit = builtins.readFile ./fish_prompt.fish;
  };
}
