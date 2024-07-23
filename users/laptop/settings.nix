{
  usr = {
    username = "aidant";
    kb = {
      layout = "us";
      keymap = "us";
    };
    display = {
      wm = "bspwm";
      monitors = [
        "DP-2"
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
