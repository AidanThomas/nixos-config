{
  pkgs,
  settings,
  ...
}: {
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Qogir-dark";
      package = pkgs.qogir-icon-theme;
      size = "32x32";
    };
    waylandDisplay =
      if settings.usr.display.backend == "wayland"
      then ""
      else "";
    settings = {
      global = {
        frame_color = "#89b4fa";
        separator_color = "frame";
        progress_bar = true;
        font = "RobotoMono Nerd Font";
        frame_width = 1;
        corner_radius = 6;
      };
      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };
      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };
      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#fab387";
      };
    };
  };
}
