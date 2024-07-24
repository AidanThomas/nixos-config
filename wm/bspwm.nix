{
  pkgs,
  lib,
  settings,
  ...
}: let
  monitorAttrs =
    map (monitor: {
      name = monitor;
      value = [
        "1"
        "2"
        "3"
        "4"
        "5"
        "6"
      ];
    })
    settings.usr.display.monitors;
  monitorDetails = lib.listToAttrs (map (monitor: {
      inherit (monitor) name value;
    })
    monitorAttrs);
in {
  imports = [
    # Programs
    ../programs/rofi.nix

    # Services
    ../services/picom.nix
    ../services/dunst.nix

    # Statusbar
    ./statusbars/${settings.usr.display.statusbar}.nix
  ];

  xsession.windowManager.bspwm = {
    enable = true;
    monitors = monitorDetails;

    settings = {
      "border_width" = 2;
      "window_gap" = 12;
      "split_ratio" = 0.52;
      "borderless_monocle" = true;
      "gapless_monocle" = true;
      "focused_border_color" = "#89b4fa";
      "normal_border_color" = "#11111b";
    };

    extraConfigEarly = ''
      ./scripts/position_monitors
    '';

    startupPrograms =
      [
        "pgrep -x sxhkd > /dev/null || sxhkd"
        "picom"
        "dunst"
      ]
      ++ (
        if settings.usr.display.wallpaperengine == "feh"
        then ["feh --bg-scale ~/.wallpapers/dawn-lake.jpg"]
        else []
      )
      ++ (
        if settings.usr.display.statusbar == "eww"
        then ["eww open statusbar"]
        else []
      );
  };

  services.sxhkd = {
    enable = true;
    keybindings = {
      # wm independent keys
      "super + Return" = "kitty";
      "super + r" = "rofi -show drun";
      "super + ESCAPE" = "pkill -USR1 -x sxhkd"; # Make sxhkd reload config files

      #bspwm keys
      "super + q" = "bspc {quit,wm -r}"; # quit/restart
      "super + {_,shift + }c" = "bspc node -{c,k}"; # close and kill
      "super + m" = "bspc desktop -l next"; # alternate between tiled and monocle layout
      # Send the newest marked node to the newest preselected node
      "super + y" = "bspc node newest.marked.local -n newest.!automatic.local";
      "super + g" = "bspc node -s biggest.window"; # swap the current node and the biggest window

      #state/flags

      # set the window state
      "super + {t,shift + t,s,f}" = "bspc node -t {tiled,pseudo_tiled, floating, fullscreen}";
      # set the node flags
      "super + ctrl + {m,x,y,z}" = "bspc node -g {marked,locked,sticky,private}";

      # focus/swap
      "super + {_, shift + }{h,j,k,l}" = "bspc node -{f,s} {west,south,north,east}";
      "super + {p,b,comma,period}" = "bspc node -f @{parent,brother,first,second}";
      "super + {_,shift + }w" = "bspc node -f {next,prev}.local.!hidden.window";
      "super + bracket{left,right}" = "bspc desktop -f {prev,next}.local";
      "super + super + {grave,Tab}" = "bspc {node,desktop} -f last";
      "super + {o,i}" = "bspc wm -h off; bspc node {older,newer} -f; bspc wm -h on";
      "super + {_,shift + }{1-6}" = "bspc {desktop -f,node -d} '^{1-6}'";
      "super + ctrl + shift + {h,l}" = "bspc node -m {prev,next} --follow";

      # preselect
      "super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";
      "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}";
      "super + ctrl + space" = "bspc node -p cancel";
      "super + ctrl + shift + space" = "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";

      # move/resize
      "super + alt + {h,j,k,l}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
      "super + alt + shift + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
      "super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
    };
  };

  home.packages =
    []
    ++ (
      if settings.usr.display.wallpaperengine == "feh"
      then [pkgs.feh]
      else []
    );

  home.file = {
    "/home/aidant/.config/bspwm/scripts".source = ./scripts;
  };
}
