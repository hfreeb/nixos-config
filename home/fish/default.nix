{ ... }:
{
  programs.fish = {
    enable = true;
    shellInit = ''
      function fish_greeting
        status --is-login
        if [ $status -eq 0 ]
          ${./doomsday.py}
        end
      end
    '';
    promptInit = builtins.readFile ./fish_prompt.fish;
  };
}
