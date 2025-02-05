{...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/.wallpapers/earth-65.jpg"
      ];

      wallpaper = [
        "DP-1,~/.wallpapers/earth-65.jpg"
        "DP-3,~/.wallpapers/earth-65.jpg"
      ];

      splash = false;
      ipc = "on";
    };
  };
}
