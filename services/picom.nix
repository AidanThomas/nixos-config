{...}: {
  services.picom = {
    enable = true;
    backend = "glx";
    fade = true;
    fadeDelta = 5;
    fadeSteps = [0.03 0.03];
    activeOpacity = 1;
    inactiveOpacity = 0.9;
    opacityRules = [
      "100:class_g = 'firefox'"
      "85:class_g = 'Spotify' && !focused"
      "95:class_g = 'Spotify' && focused"
      "90:class_g = 'kitty' && !focused"
      "100:class_g = 'kitty' && focused"
    ];
    shadow = true;
    shadowExclude = [
      "name = 'Notification'"
      "class_g ?= 'Notify-osd'"
      "_GTK_FRAME_EXTENTS@:c"
      "name = 'Eww - statusbar'"
    ];
    shadowOffsets = [(-5) (-5)];
    wintypes = {
      dock = {shadow = false;};
    };
    vSync = true;
    settings = {
      blur = {
        method = "dual_kawase";
        strength = 4;
        background = true;
        kern = "3x3box";
        background-exclude = [
          "window_type = 'dock'"
          "window_type = 'desktop'"
          "_GTK_FRAME_EXTENTS@:c"
          "class_g = 'eww'"
          "name = 'Eww - statusbar'"
          "name = 'Eww - statusbar0'"
          "name = 'Eww - statusbar1'"
          "name = 'Eww - statusbar2'"
        ];
      };
      corner-radius = 6;
      rounded-corners-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "class_g = 'Eww'"
      ];
    };
  };
}
