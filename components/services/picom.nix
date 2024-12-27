{pkgs, ...}: {
  home.packages = [
    pkgs.picom
  ];

  home.file = {
    "/home/aidant/.config/picom/picom.conf".text = ''
      active-opacity = 1;
      animations = ({
        triggers = [ "close" ];
        preset = "disappear";
        duration = 0.2;
        scale = 0.5;
      }, {
        triggers = [ "open" ];
        preset = "appear";
        duration = 0.2;
        scale = 0.5;
      }, {
        triggers = [ "geometry" ];
        preset = "geometry-change";
        duration = 0.2
      }, {
        triggers = [ "hide"];
        preset = "slide-out";
        direction = "right";
        duration = 0.2;
      }, {
        triggers = [ "show" ];
        preset = "slide-in";
        direction = "left";
        duration = 0.2
      });
      backend = "glx";
      blur: { background = true; background-exclude = [ "window_type = 'dock'" , "window_type = 'desktop'" , "_GTK_FRAME_EXTENTS@:c" , "class_g = 'eww'" , "name = 'Eww - statusbar'" , "name = 'Eww - statusbar0'" , "name = 'Eww - statusbar1'" , "name = 'Eww - statusbar2'" ]; kern = "3x3box"; method = "dual_kawase"; strength = 4; };
      corner-radius = 6;
      blur-background-exclude = [
        "window_type = 'dock'",
        "window_type = 'desktop'",
        "GTK_FRAME_EXTENTS@:c"
      ];
      fade-delta = 5;
      fade-exclude = [  ];
      fade-in-step = 0.030000;
      fade-out-step = 0.030000;
      fading = true;
      inactive-opacity = 0.900000;
      opacity-rule = [ "100:class_g = 'firefox'" , "85:class_g = 'Spotify' && !focused" , "95:class_g = 'Spotify' && focused" , "90:class_g = 'kitty' && !focused" , "100:class_g = 'kitty' && focused" ];
      rounded-corners-exclude = [ "window_type = 'dock'" , "window_type = 'desktop'" , "class_g = 'Eww'" ];
      shadow = true;
      shadow-exclude = [ "name = 'Notification'" , "class_g ?= 'Notify-osd'" , "_GTK_FRAME_EXTENTS@:c" , "name = 'Eww - statusbar'" ];
      shadow-offset-x = -5;
      shadow-offset-y = -5;
      shadow-opacity = 0.750000;
      vsync = true;
      wintypes: { dock = { shadow = false; }; };
    '';
  };
}
