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
        "DP-2"
        "DP-3"
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
  importFiles = [
    # Programs
    ../../programs/git.nix
    ../../programs/bash.nix

    # Services
    ../../services/caffeine.nix

    # Terminal extras
    ../../terminals/starship.nix
    ../../terminals/neofetch.nix
  ];
}
