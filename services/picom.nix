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
      "80:class_g = 'kitty' && !focused"
      "90:class_g = 'kitty' && focused"
    ];
    shadow = true;
    shadowExclude = [
      "name = 'Notification'"
      "class_g ?= 'Notify-osd'"
      "_GTK_FRAME_EXTENTS@:c"
      "name = 'Eww - statusbar'"
    ];
    shadowOffsets = [(-7) (-7)];
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
        ];
      };
      corner-radius = 6;
      round-corners-exlude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
      ];
    };
  };
}
