{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    font = "RobotoMono Nerd Font 12";
    terminal = "${pkgs.kitty}/bin/kitty";
    theme = ./themes/rofi/catppuccin.rasi;
    extraConfig = {
      modi = "run,drun,window";
      icon-theme = "Qogir-dark";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      location = 0;
      disbale-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-window = "   Window ";
      display-Network = " 󰤨  Network ";
      display-run = "   Run ";
      sidebar-mode = true;
      kb-mode-next = "Control+l";
      kb-mode-previous = "Control+h";
      kb-mode-complete = "Control+Shift+l";
      kb-remove-to-eol = "";
      kb-remove-char-back = "BackSpace,Shift+BackSpace";
    };
  };
}
