{inputs, ...}: {
  imports = [inputs.hyprpanel.homeManagerModules.hyprpanel];

  programs.hyprpanel = {
    enable = true;
    overwrite.enable = true;
    theme = "catppuccin_mocha";
    layout = {
      "bar.layouts" = {
        "0" = {
          left = ["dashboard" "workspaces" "windowtitle"];
          middle = ["media" "cava"];
          right = ["storage" "ram" "systray" "microphone" "volume" "notifications" "clock"];
        };
        "1" = {
          left = [];
          middle = [];
          right = [];
        };
      };
    };
    settings = {
      bar = {
        launcher = {
          autoDetectIcon = true;
        };

        workspaces = {
          ignored = "11";
          showWsIcons = true;
          # workspaceIconMap = {
          #   "1" = "k";
          # };
        };

        windowtitle = {
        };

        media = {
          format = "{title: - }{artist}";
          show_active_only = true;
        };

        customModules.cava = {
          showIcon = false;
          stereo = true;
        };

        customModules.storage = {
          round = true;
        };

        customModules.ram = {
          round = true;
        };

        notifications = {
          show_total = true;
        };

        clock = {
          format = "%H%M   %a %_d  %b";
          showIcon = false;
        };
      };
    };
  };
}
