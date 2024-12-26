{
  pkgs,
  settings,
  ...
}: {
  imports = [
    # ./statusbars/${settings.usr.display.statusbar}.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "monitor" = [
        # "DP-1, 2560x1440@165.00Hz, 0x0, 1"
        # "DP-3, disable"
      ];
      "$mod" = "SUPER";
      bind =
        [
          "$mod, RETURN, exec, kitty"
          "$mod, Q, exec, hyprctl dispatch exit"
          "$mod, R, exec, wofi --show drun"
          "$mod, C, killactive,"
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
      # exec-once =
      #   [
      #     # "waybar"
      #     # "mpvpaper -f -o \"no-audio loop\" eDP-1 ~/.wallpapers/AnimatedCosmereWallpaper.mp4"
      #     "swww init && swww img ~/.wallpapers/dawn-lake.jpg"
      #   ]
      #   ++ (
      #     if settings.usr.display.wallpaperengine == "mpvpaper"
      #     then ["mpvpaper -f -o \"no-audio loop\" eDP-1 ~/.wallpapers/AnimatedCosmereWallpaper.mp4"]
      #     else
      #       (
      #         if settings.usr.display.wallpaperengine == "swww"
      #         then ["sww init && swww img ~/.wallpapers/dawn-lake.jpg"]
      #         else []
      #       )
      #   )
      #   ++ (
      #     if settings.usr.display.statusbar == "waybar"
      #     then ["waybar"]
      #     else []
      #   );

      general = {
        gaps_out = 10;
      };

      decoration = {
        inactive_opacity = 0.9;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };

      misc = {
        disable_hyprland_logo = false;
        disable_splash_rendering = false;
      };

      env = [
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];
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
    pkgs.xdg-desktop-portal-hyprland
    pkgs.wofi
    pkgs.dunst
    pkgs.egl-wayland
  ];

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
