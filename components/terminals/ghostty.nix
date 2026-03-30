{...}: {
  imports = [
    ./fastfetch.nix
    ./starship.nix
    ./tmux.nix
  ];

  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    installVimSyntax = true;
    settings = {
      font-family = "RobotoMono Nerd Font";
      font-size = 12;
      theme = "Catppuccin Mocha";
      background = "#11111b";
      cursor-text = "#11111b";
      background-opacity = 0.91;
      background-blur = 15;
      title = " ";
      macos-titlebar-proxy-icon = "hidden";
      window-height = 55;
      window-width = 220;
      window-position-x = 75;
      window-position-y = 75;
    };
  };
}
