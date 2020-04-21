{ config, pkgs, lib, ... }:
let
  cfg = config.me.i3;
in {
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
    home.packages = with pkgs; [ feh maim xclip ];

    home.file.".xinitrc".text = ''
      exec i3
    '';

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
        terminal = "${pkgs.termite}/bin/termite";
        menu = "${pkgs.dmenu}/bin/dmenu_run -p \"Run:\" -l 10";
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
          (lib.filterAttrs (name: _: name == "name" || name == "assigns") workspace)
        ) workspaces);

        keybindings = {
          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+Shift+q" = "kill";
          "${modifier}+d" = "exec ${menu}";

          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";

          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";

          "${modifier}+b" = "split h";
          "${modifier}+v" = "split v";
          "${modifier}+f" = "fullscreen toggle";

          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+space" = "focus mode_toggle";

          "${modifier}+a" = "focus parent";

          "${modifier}+Shift+minus" = "move scratchpad";
          "${modifier}+minus" = "scratchpad show";

          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+r" = "restart";
          "${modifier}+Shift+e" = "exec ${pkgs.i3}/bin/i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' '${pkgs.i3}/bin/i3-msg exit'";

          "${modifier}+r" = "mode resize";

          "${modifier}+c" = "exec ${pkgs.firefox}/bin/firefox";
          "${modifier}+Shift+d" = "exec --no-startup-id ${pkgs.i3}/bin/i3-dmenu-desktop";
          "${modifier}+e" = "exec ${pkgs.termite}/bin/termite -e ${pkgs.ranger}/bin/ranger";
          "${modifier}+s" = "exec ${pkgs.maim}/bin/maim -s | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png";
          "${modifier}+Shift+s" = "exec ${pkgs.maim}/bin/maim -s $HOME/Pictures/screenshots/$(date --iso-8601=\"seconds\").png";
          "${modifier}+i" = "exec i3lock -t -i ${cfg.background}";
          "${modifier}+Shift+i" = "exec i3lock -t -i ${cfg.background} && ${pkgs.systemd}/bin/systemctl suspend";

          # Pulse Audio controls
          "XF86AudioRaiseVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume 0 +5%"; # increase sound volume
          "XF86AudioLowerVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume 0 -5%"; # decrease sound volume
          "XF86AudioMute" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute 0 toggle"; # mute sound

          # Screen brightness controls
          "XF86MonBrightnessUp" = "exec ${pkgs.xorg.xbacklight}/bin/xbacklight -inc 20"; # increase screen brightness
          "XF86MonBrightnessDown" = "exec ${pkgs.xorg.xbacklight}/bin/xbacklight -dec 20"; # decrease screen brightness
        } // builtins.listToAttrs (lib.imap0 (i: v: {
          name = "${modifier}+Shift+${toString i}";
          value = "move container to workspace ${v.name}";
        }) workspaces) // builtins.listToAttrs (lib.imap0 (i: v: {
          name = "${modifier}+${toString i}";
          value = "workspace ${v.name}";
        }) workspaces);

        startup = [
          {
            command = "${pkgs.feh}/bin/feh --bg-scale ${cfg.background}";
            notification = false;
          }
          {
            command = "${pkgs.i3}/bin/i3-msg workspace " + (builtins.elemAt workspaces 1).name;
            notification = false;
          }
          {
            command = "${pkgs.dunst}/bin/dunst";
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
          statusCommand = "${pkgs.i3status}/bin/i3status -c ${./status.conf}";
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
