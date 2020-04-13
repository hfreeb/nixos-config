{ ... }:
{
  programs.fish = {
    enable = true;
    shellInit = ''
      set fish_greeting
    '';
    promptInit = builtins.readFile ./fish_prompt.fish;
  };
}
