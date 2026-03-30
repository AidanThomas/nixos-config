{
  name = "desktop";
  usr = {
    username = "aidant";
    kb = {
      layout = "us";
      keymap = "us";
    };
    display = {
      wm = "hyprland";
      monitors = [
        {
          name = "DP-1";
          mode = "2560x1440@165.00Hz";
          primary = true;
        }
        {
          name = "DP-3";
          role = "right-vertical";
          mode = "2560x1440@165.00Hz";
          position = "right";
          vertical = true;
        }
      ];
      statusbar = "eww";
      backend = "wayland";
    };
    terminal = "ghostty";
  };
  sys = {
    hostname = "nixos";
  };
  importFiles = [
    # Programs
    ../../components/programs/git.nix
    ../../components/programs/bash.nix

    # Services
    ../../components/services/caffeine.nix
  ];
}
