{
  name = "desktop";
  usr = {
    username = "aidant";
    kb = {
      layout = "us";
      keymap = "us";
    };
    display = {
      wm = "bspwm";
      monitors = [
        "DP-0"
        "DP-4"
      ];
      statusbar = "eww";
      backend = "x11";
    };
    terminal = "kitty";
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

    # Terminal extras
    ../../components/terminals/starship.nix
    ../../components/terminals/fastfetch.nix
  ];

  scripts = [
    ./scripts/monitors.nix
  ];
}
