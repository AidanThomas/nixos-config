{
  configName = "desktop";
  usr = {
    username = "aidant";
    display = {
      wm = "bspwm";
      monitors = [
        # "DP-0"
        "DP-2"
        # "DP-4"
      ];
      statusbar = "eww";
      wallpaperengine = "feh";
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
