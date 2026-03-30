{
  pkgs,
  settings,
  inputs,
  ...
}: let
  mkMonitorConfig = m:
    if (m.primary or false)
    then "${m.name}, ${m.mode}, 0x0, 1"
    else if m.position == "right"
    then
      if m.vertical
      then "${m.name}, ${m.mode}, 2560x-820, 1, transform, 3"
      else throw "Only vertical monitor is supported"
    else throw "Unknown monitor role: ${m.role}";
in {
  imports = [
    ./statusbars/${settings.usr.display.statusbar}.nix

    ../programs/hyprlock.nix
    ../programs/rofi.nix

    ../services/hyprpaper.nix
    ../services/swaync.nix
    ../services/swayosd.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
    settings = {
      "monitor" = map mkMonitorConfig settings.usr.display.monitors;
      "$mod" = "SUPER";
      bind =
        [
          "$mod, RETURN, exec, ${settings.usr.terminal}"
          "$mod, R, exec, rofi -show drun"
          "$mod, C, killactive,"
          "$mod, F, fullscreen, 0"
          "$mod, M, fullscreen, 1"
          "$mod, S, togglefloating, active"
          # ",mouse_left,workspace,-1"
          # ",mouse_right,workspace,+1"
          "$mod, H, movefocus, l"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, r"
          "$mod&SHIFT, H, movewindow, l"
          "$mod&SHIFT, J, movewindow, d"
          "$mod&SHIFT, K, movewindow, u"
          "$mod&SHIFT, L, movewindow, r"

          "$mod&SHIFT, S, exec, hyprshot -m region"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move  to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bindle = [
        ", XF86AudioRaiseVolume, exec, ~/.config/eww/scripts/audio --change-volume speakers up"
        ", XF86AudioLowerVolume, exec, ~/.config/eww/scripts/audio --change-volume speakers down --down"
        ", XF86AudioMute, exec, ~/.config/eww/scripts/audio --mute-speakers"
      ];
      bindl = [
        ", XF86AudioPlay, exec, playerctl -p spotify play-pause"
        ", XF86AudioNext, exec, playerctl -p spotify next"
        ", XF86AudioPrev, exec, playerctl -p spotify previous"
      ];
      exec-once = [
        "eww open statusbar"
        "swaync"
      ];

      general = {
        gaps_out = 10;
        layout = "dwindle";
        resize_corner = 3;
        resize_on_border = true;
      };

      decoration = {
        inactive_opacity = 0.9;
        rounding = 5;
        dim_inactive = false;
      };

      gesture = ["3, horizontal, workspace"];

      misc = {
        disable_hyprland_logo = false;
        disable_splash_rendering = false;
      };

      opengl = {
        nvidia_anti_flicker = true;
      };

      windowrule = [
        "match:class discord, monitor DP-3"
        "match:class WebCord, monitor DP-3"

        "match:class firefox, workspace name:browser"
        "match:class kitty, workspace name:terminal"
        "match:class spotify, workspace name:music"
        "match:class steam.*, workspace name:steam"
        "match:class nemo, workspace name:files"

        "match:class firefox, opacity 1.0 override"
        "match:class firefox, no_blur on"
      ];

      workspace = [
        "1,monitor:DP-1, defaultName:terminal, persistent:true"
        "2,monitor:DP-1, defaultName:browser, persistent:true"
        "3,monitor:DP-1, defaultName:steam, persistent:true"
        "4,monitor:DP-1, defaultName:files, persistent:true"
        "5,monitor:DP-1, defaultName:music, persistent:true"
        "6,monitor:DP-1"
        "7,monitor:DP-1"
        "8,monitor:DP-1"
        "9,monitor:DP-1"
        "10,monitor:DP-1"
        "11,monitor:DP-3"
      ];

      layerrule = [
        "no_anim on, match:namespace hyprpicker"
        "no_anim on, match:namespace selection"
      ];

      env = [
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];

      input = {
        repeat_delay = 250; # ms before repeat starts
        repeat_rate = 40; # repeats per second
      };
    };
    extraConfig = ''
      xwayland {
          force_zero_scaling = true
      }
    '';
  };

  home.packages = [
    pkgs.wl-clipboard
    pkgs.grim
    pkgs.slurp
    pkgs.egl-wayland
    pkgs.spotify-cli-linux
    pkgs.hyprshot
    pkgs.playerctl
  ];

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
