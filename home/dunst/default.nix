{ pkgs, ... }:
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        alignment = "center";
        follow = "keyboard";
        frame_width = 1;
        geometry = "300x5-30+20";
        padding = 5;
        font = "Iosevka Term";
        separator_color = "#383838";
        frame_color = "#383838";
        word_wrap = true;
      };
      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
        history = "ctrl+grave";
        context = "ctrl+shift+period";
      };
      urgency_low = {
        background = "#282828";
        foreground = "#a4df7d";
        timeout = 5;
      };
      urgency_normal = {
        background = "#282828";
        foreground = "#80ad61";
        timeout = 10;
      };
      urgency_critical = {
        background = "#282828";
        foreground = "#7ddc17";
        timeout = 0;
      };
    };
  };
}
