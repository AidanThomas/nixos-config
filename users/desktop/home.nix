{
  pkgs,
  settings,
  ...
}: let
  scripts =
    map (script: ./scripts/${script})
    (builtins.attrNames (builtins.readDir ./scripts));
in {
  imports =
    [
      ../../components/wm/${settings.usr.display.wm}.nix
      ../../components/terminals/${settings.usr.terminal}.nix
    ]
    ++ settings.importFiles
    ++ scripts;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"];

  home.username = settings.usr.username;
  home.homeDirectory = "/home/" + settings.usr.username;

  # You should not change this value, even if you update Home Manager
  home.stateVersion = "24.05";

  home.packages = [
    # Development
    pkgs.rustup
    pkgs.go
    pkgs.gccgo13
    pkgs.gnumake
    pkgs.lua-language-server

    # Font
    (pkgs.nerdfonts.override {fonts = ["RobotoMono"];})

    # Extra
    pkgs.alejandra
    pkgs.cinnamon.nemo
    pkgs.discord
    pkgs.ripgrep
    pkgs.fd
    pkgs.fzf
    pkgs.obsidian
    pkgs.discord # Use betterdiscordctl to install BetterDiscord
    pkgs.gimp
    pkgs.spotify
    pkgs.steam
    pkgs.shutter
    pkgs.keepassxc
    pkgs.pulsemixer
    pkgs.vscode

    # Theming
    pkgs.capitaine-cursors
    pkgs.la-capitaine-icon-theme
    pkgs.qogir-theme # GTK theme
    pkgs.qogir-icon-theme # Icons and cursors

    (pkgs.writeShellScriptBin "switch-system" ''
      echo "Rebuilding nixos config for: desktop"
      sudo nixos-rebuild switch --flake ~/.dotfiles#desktop
    '')
    (pkgs.writeShellScriptBin "switch-home" ''
      echo "Rebuilding home-manager config for: desktop"
      home-manager switch --flake ~/.dotfiles#desktop
    '')
  ];

  home.file = {
    "/home/aidant/.wallpapers".source = ../../components/symlinks/wallpapers;
    "/home/aidant/.local/share/applications".source = ../../components/symlinks/applications;
    "/home/aidant/.config/BetterDiscord/themes/mocha.theme.css".text = ''
       /**
       * @name Catppuccin Mocha
       * @author winston#0001
       * @authorId 505490445468696576
       * @version 0.2.0
       * @description 🎮 Soothing pastel theme for Discord
       * @website https://github.com/catppuccin/discord
       * @invite r6Mdz5dpFc
       * **/

      @import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css");
    '';
  };

  # Configure X
  xsession = {
    enable = true;
  };
  xresources = {
    properties = {
      "Xft.dpi" = 109; # Calculate using https://dpi.lv/
    };
  };
  home.pointerCursor = {
    # Themes:
    # - capitaine-cursors
    # - Qogir
    # - Qogir-dark
    name = "Qogir";
    package = pkgs.qogir-icon-theme;
    size = 36;
    gtk.enable = true;
    x11.enable = true;
  };

  # Configure gtk
  gtk = {
    # Themes:
    # - capitaine-cursors
    # - Qogir
    # - Qogir-dark
    enable = true;
    cursorTheme = {
      name = "Qogir";
      package = pkgs.qogir-icon-theme;
      size = 36;
    };
    # Themes:
    # - la-capitaine-icon-theme
    # - Qogir
    # - Qogir-dark
    iconTheme = {
      name = "Qogir-dark";
      package = pkgs.qogir-icon-theme;
    };
    # Themes:
    # - Qogir
    # - Qogir-Dark
    theme = {
      name = "Qogir-Dark";
      package = pkgs.qogir-theme;
    };
  };

  # Let home manager manage itself
  programs.home-manager.enable = true;
}
