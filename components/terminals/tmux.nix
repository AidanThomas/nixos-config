{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    terminal = "screen-256color";
    baseIndex = 1;

    plugins = with pkgs.tmuxPlugins; [
      copycat
      extrakto
    ];

    extraConfig = ''
      bind r source-file ~/.config/tmux/tmux.conf \; display "Configuration reloaded"

      # Remap prefix from ctrl-b to ctrl-a
      unbind C-b
      set-option -g prefix C-a
      bind-key C-a send-prefix

      unbind C-v
      unbind C-h
      bind C-h split-window -v -c "#{pane_current_path}"
      bind C-v split-window -h -c "#{pane_current_path}"
      unbind '"'
      unbind %

      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      set -g mouse on
      set-option -g allow-rename off

      bind -n M-c new-window -c "#{pane_current_path}";
      bind -n M-n next-window
      bind -n M-p previous-window

      bind q kill-pane
      bind Q kill-window

      set-window-option -g mode-keys vi
      set -g base-index 1
      set-window-option -g pane-base-index 1

      unbind -T copy-mode-vi Space;
      unbind -T copy-mode-vi Enter;

      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"

      bind -r Left resize-pane -L 5
      bind -r Up resize-pane -U 5
      bind -r Down resize-pane -D 5
      bind -r Right resize-pane -R 5

      ########################################
      # DESIGN
      ########################################

      set -g @rosewater "#f5e0dc"
      set -g @flamingo "#f2cdcd"
      set -g @pink "#f5c2e7"
      set -g @mauve "#cba6f7"
      set -g @red "#f38ba8"
      set -g @maroon "#eba0ac"
      set -g @peach "#fab387"
      set -g @yellow "#f9e2af"
      set -g @green "#a6e3a1"
      set -g @teal "#94e2d5"
      set -g @sky "#89dceb"
      set -g @sapphire "#74c7ec"
      set -g @blue "#89b4fa"
      set -g @lavender "#b4befe"
      set -g @text "#cdd6f4"
      set -g @subtext_1 "#bac2de"
      set -g @subtext_0 "#a6adc8"
      set -g @overlay_2 "#9399b2"
      set -g @overlay_1 "#7f849c"
      set -g @overlay_0 "#6c7086"
      set -g @surface_2 "#585b70"
      set -g @surface_1 "#45475a"
      set -g @surface_0 "#313244"
      set -g @base "#1e1e2e"
      set -g @mantle "#181825"
      set -g @crust "#11111b"

      set -g visual-activity off
      set -g visual-bell off
      set -g visual-silence off
      set -g monitor-activity off
      set -g bell-action none

      # Clock mode
      run-shell "tmux set -g clock-mode-color $(tmux show -vg @sapphire)"

      # Copy mode
      set -g mode-style "fg=black bg=#{@sapphire} bold"

      # Panes
      set -g pane-border-style "fg=#{@overlay_0}"
      set -g pane-active-border-style "fg=#{@sapphire}"

      # Statusbar
      set -g status-position bottom
      set -g status-justify left
      set -g status-style "fg=#{@text}"

      set -g status-left " "
      set -g status-left-length 10

      set -g status-right-style "fg=#{@text}"
      set -g status-right "#[fg=#{@green}]#[fg=#{@crust}]#[bg=#{@green}]󰂄#[fg=#{@green}]#[bg=default]#[fg=default] #(pmset -g batt | awk '/InternalBattery/ { print $3 }' | tr -d ';')  #[fg=#{@peach}]#[fg=#{@crust}]#[bg=#{@peach}]󰃵#[fg=#{@peach}]#[bg=default]#[fg=default] %a %d %b %H:%M "
      set -g status-right-length 50

      setw -g window-status-current-format  "#[fg=#{@mauve}]#[bg=default]#[fg=#{@crust}]#[bg=#{@mauve}]#I#[fg=#{@mauve}]#[bg=#{@surface_0}]#[fg=#{@text}] #W #[fg=#{@surface_0}]#[bg=default]"
      setw -g window-status-format "#[fg=#{@blue}]#[bg=default]#[fg=#{@crust}]#[bg=#{@blue}]#I#[fg=#{@blue}]#[bg=default]#[fg=#{@text}] #W  "


      #############################################
    '';
  };

  # home.file.".config/tmux/tmux.conf".source = ./config/tmux.conf
}
