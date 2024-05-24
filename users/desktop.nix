{
    usr = {
      username = "aidant";
      display = {
        wm = "awesome";
        statusbar = "eww";
        wallpaperengine = "awesome";
        backend = "x11";
        dpi = 109; # Calculate using https://dpi.lv/
      };
      theme = {
        cursorSize = 24;
      };
      terminal = "kitty";
    };
    sys = {
      hostname = "nixos";
      hardware.nvidia = true;
    };
}
