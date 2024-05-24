{ pkgs, usr, ... }:
{
    imports = [

    ] ++ (if usr.display.wm.statusbar == "waybar" then [ ./statusbars/waybar.nix] else 
         (if usr.display.wm.statusbar == "eww" then [ ./statusbars/hyprland/eww.nix] else []));

    wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = false;
        settings = {
            "monitor" = "Unknown-1,disable";
            "$mod" = "SUPER";
            bind = [
                "$mod, RETURN, exec, kitty"
                "$mod, T, exec, WAYLAND_DISPLAY=1 wezterm"
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
            exec-once = [
                # "waybar"
                # "mpvpaper -f -o \"no-audio loop\" eDP-1 ~/.wallpapers/AnimatedCosmereWallpaper.mp4"
                "swww init && swww img ~/.wallpapers/dawn-lake.jpg"
            ] ++ (if usr.display.wm.wallpaperengine == "mpvpaper" then
                 [ "mpvpaper -f -o \"no-audio loop\" eDP-1 ~/.wallpapers/AnimatedCosmereWallpaper.mp4" ] else 
                 (if usr.display.wm.wallpaperengine == "swww" then
                 [ "sww init && swww img ~/.wallpapers/dawn-lake.jpg"] else []))
              ++ (if usr.display.wm.statusbar == "waybar" then [ "waybar" ] else []);

            general = {
                gaps_out = 10;
            };

            decoration = {
                inactive_opacity = 0.9;
            };

            input = {
                kb_layout = "gb,us";
                kb_options = "grp:caps_toggle";
            };

            gestures = {
                workspace_swipe = true;
                workspace_swipe_fingers = 3;
            };

            misc = {
                disable_hyprland_logo = true;
                disable_splash_rendering = true;
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
    ] ++ (if usr.display.wm.wallpaperengine == "mpvpaper" then [ pkgs.mpvpaper ] else
         (if usr.display.wm.wallpaperengine == "swww" then [ pkgs.swww ] else []));
}
