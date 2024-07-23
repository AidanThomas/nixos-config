{
  usr = {
    username = "aidant";
    kb = {
      layout = "gb";
      keymap = "uk";
    };
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
    };
    terminal = "kitty";
  };
  sys = {
    hostname = "nixos";
  };
}
