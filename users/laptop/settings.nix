{
  name = "laptop";
  usr = {
    username = "aidant";
    kb = {
      layout = "us";
      keymap = "us";
    };
    display = {
      wm = "hyprland";
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
    ../../components/programs/codex.nix

    # Services
    ../../components/services/caffeine.nix
  ];
}
