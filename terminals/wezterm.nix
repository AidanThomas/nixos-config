{ ... }:
{
    programs.wezterm = {
        enable = true;
        enableBashIntegration = true;
        extraConfig = ''
            local wezterm = require("wezterm")
            local config = {}

            if wezterm.config_builder then
                config = wezterm.config_builder()
            end

            config.front_end = "OpenGL"
            config.color_scheme = "catppuccin-mocha"
            config.colors = {
                background = "#11111B"
            }

            config.use_fancy_tab_bar = false
            config.hide_tab_bar_if_only_one_tab = true
            config.enable_scroll_bar = false
            config.enable_wayland = false

            config.window_padding = {
                left = 0,
                right = 0,
                top = 0,
                bottom = 0,
            }

            config.window_background_opacity = 0.9

            config.font = wezterm.font("RobotoMono Nerd Font Mono",
                {
                    weight = "Regular"
                })
            config.cell_width = 1
            config.font_size = 13.0

            return config
        '';
    };
}
