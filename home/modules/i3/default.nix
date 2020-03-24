{ config, pkgs, lib, ... }:
let
  cfg = config.me.i3;
in {
  imports = [
    ../dunst
  ];

  options.me.i3 = {
    background = with lib; mkOption { type = types.path; };
    monitorAssigns = with lib; mkOption { type = types.attrsOf types.str; default = {}; };
  };

  config = let
    workspaces = [
      { name = "0: root"; assigns = []; }
      { name = "1: main"; assigns = []; }
      { name = "2: www"; assigns = [
        { class = "^Firefox$"; }
      ]; }
      { name = "3: dev"; assigns = []; }
      { name = "4: p2p"; assigns = [
        { class = "^discord$"; }
      ]; }
      { name = "5: misc1"; assigns = []; }
      { name = "6: misc2"; assigns = []; }
      { name = "7: misc3"; assigns = []; }
      { name = "8: misc4"; assigns = []; }
      { name = "9: misc5"; assigns = []; }
    ];
  in {
    home.packages = with pkgs; [ feh maim ];

    home.file.".xinitrc".text = ''
      exec i3
    '';

    home.file.".config/i3/status.conf".text = builtins.readFile ./status.conf;

    home.file.".config/i3/background.png".source = cfg.background;

    xsession.windowManager.i3 = rec {
      enable = true;
      config = let
        bg = "#282828";
        blue = "#458588";
        darkGrey = "#1d2021";
        purple = "#b16286";
        yellow = "#d79921";
        red = "#cc241d";
        white = "#ffffff";
      in rec {
        modifier = "Mod4";
        terminal = "termite";
        menu = "dmenu_run -p \"Run:\" -l 10";
        fonts = [ "Iosevka Term" "Font Awesome 8" ];

        window = {
          border = 2;
          titlebar = false;
        };

        floating = {
          border = 2;
          titlebar = false;
        };

        assigns = lib.listToAttrs (map (workspace: lib.mapAttrs'
          (name: value: lib.nameValuePair (if name == "assigns" then "value" else name) value)
          (lib.filterAttrs (name: value: name == "name" || name == "assigns") workspace)
        ) workspaces);

        keybindings = lib.mkOptionDefault ({
          "${modifier}+c" = "exec firefox";
          "${modifier}+Shift+d" = "exec --no-startup-id i3-dmenu-desktop";
          "${modifier}+e" = "exec termite -e ranger";
          "${modifier}+s" = "exec maim -s | xclip -selection clipboard -t image/png";
          "${modifier}+Shift+s" = "exec maim -s $HOME/Pictures/screenshots/$(date --iso-8601=\"seconds\").png";
          "${modifier}+i" = "exec i3lock -t -i $HOME/.config/i3/background.png";
          "${modifier}+Shift+i" = "exec i3lock && systemctl suspend";

          # Pulse Audio controls
          "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume 0 +5%"; #increase sound volume
          "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume 0 -5%"; #decrease sound volume
          "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute 0 toggle"; # mute sound

          # Screen brightness controls
          "XF86MonBrightnessUp" = "exec xbacklight -inc 20"; # increase screen brightness
          "XF86MonBrightnessDown" = "exec xbacklight -dec 20"; # decrease screen brightness
        } // builtins.listToAttrs (lib.imap0 (i: v: {
          name = "${modifier}+Shift+${toString i}";
          value = "move container to workspace ${v.name}";
        }) workspaces) // builtins.listToAttrs (lib.imap0 (i: v: {
          name = "${modifier}+${toString i}";
          value = "workspace ${v.name}";
        }) workspaces));

        startup = [
          {
            command = "feh --bg-scale $HOME/.config/i3/background.png";
            notification = false;
          }
          {
            command = "i3-msg workspace " + (builtins.elemAt workspaces 1).name;
            notification = false;
          }
          {
            command = "dunst";
            notification = false;
          }
        ];

        colors = {
          focused = {
            border = blue;
            background = blue;
            text = darkGrey;
            indicator = purple;
            childBorder = darkGrey;
          };
          focusedInactive = {
            border = darkGrey;
            background = darkGrey;
            text = yellow;
            indicator = purple;
            childBorder = darkGrey;
          };
          unfocused = {
            border = darkGrey;
            background = darkGrey;
            text = yellow;
            indicator = purple;
            childBorder = darkGrey;
          };
          urgent = {
            border = red;
            background = red;
            text = white;
            indicator = red;
            childBorder = red;
          };
        };

        bars = [ {
          position = "top";
          statusCommand = "i3status -c $HOME/.config/i3/status.conf";
          colors = {
            background = bg;
            focusedWorkspace = {
              border = bg;
              background = darkGrey;
              text = red;
            };
            activeWorkspace = {
              border = darkGrey;
              background = darkGrey;
              text = yellow;
            };
            inactiveWorkspace = {
              border = darkGrey;
              background = darkGrey;
              text = yellow;
            };
            urgentWorkspace = {
              border = red;
              background = red;
              text = bg;
            };
          };
        } ];
      };

      extraConfig = lib.concatStringsSep "\n" (lib.mapAttrsToList
        (name: value: "workspace \"${(builtins.elemAt workspaces (lib.toInt name)).name}\" output ${value}")
        cfg.monitorAssigns
      );
    };
  };
}
