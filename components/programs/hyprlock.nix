{...}: {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
        immediate_render = true;
      };

      animations = {
        enabled = true;
      };

      background = [
        {
          monitor = "";
          path = "~/.wallpapers/earth-65.jpg";

          blur_passes = 3;
          blur_size = 8;

          brightness = 0.55;
          contrast = 1.05;
          vibrancy = 0.15;
        }
      ];

      # Clock
      label = [
        {
          monitor = "DP-1";

          text = "$TIME";
          font_size = 96;
          font_family = "sans-serif";
          color = "rgba(ffffffee)";

          position = "0, 180";
          halign = "center";
          valign = "center";

          shadow_passes = 2;
          shadow_size = 4;
          shadow_color = "rgba(00000088)";
        }

        # Date
        {
          monitor = "DP-1";

          text = "cmd[update:60000] date '+%A, %d %B'";
          font_size = 24;
          font_family = "sans-serif";
          color = "rgba(ffffffcc)";

          position = "0, 105";
          halign = "center";
          valign = "center";

          shadow_passes = 2;
          shadow_size = 3;
          shadow_color = "rgba(00000088)";
        }

        # User
        {
          monitor = "DP-1";

          text = "󰀄  $USER";
          font_size = 18;
          font_family = "sans-serif";
          color = "rgba(ffffffbb)";

          position = "0, -35";
          halign = "center";
          valign = "center";
        }

        # Failed password message
        {
          monitor = "DP-1";

          text = "$FAIL";
          font_size = 14;
          font_family = "sans-serif";
          color = "rgba(ff7b72ff)";

          position = "0, -155";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          monitor = "DP-1";

          size = "320, 55";
          position = "0, -95";

          halign = "center";
          valign = "center";

          outline_thickness = 2;

          outer_color = "rgba(ffffff44)";
          inner_color = "rgba(111318cc)";
          font_color = "rgba(ffffffff)";

          check_color = "rgba(8aadf4ff)";
          fail_color = "rgba(ed8796ff)";
          capslock_color = "rgba(eed49fff)";

          rounding = 14;

          dots_size = 0.2;
          dots_spacing = 0.25;
          dots_center = true;

          fade_on_empty = false;

          placeholder_text = "<span foreground=\"##aaaaaa\">Enter password...</span>";

          hide_input = false;
          fail_text = "";

          shadow_passes = 2;
          shadow_size = 4;
          shadow_color = "rgba(00000066)";
        }
      ];
    };
  };
}
