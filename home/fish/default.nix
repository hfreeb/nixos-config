{ ... }:
{
  programs.fish = {
    enable = true;
    promptInit = builtins.readFile ./fish_prompt.fish;
    shellInit = ''
      function fish_greeting
        status --is-login
        if [ $status -eq 0 ]
          ${./doomsday.py}
        end
      end
      fish_vi_key_bindings
    '';
  };
}
