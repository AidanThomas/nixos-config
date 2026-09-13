{...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      wallpaper = [
        {
          monitor = "DP-1";
          path = "~/.wallpapers/earth-65.jpg";
        }
        {
          monitor = "DP-3";
          path = "~/.wallpapers/earth-65.jpg";
        }
      ];

      splash = false;
      ipc = "on";
    };
  };
}
