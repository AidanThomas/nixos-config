{
  pkgs,
  settings,
  ...
}: let
  aliases = {
    develop = "nix develop ~/.dotfiles#development";

    ll = "ls -la";
    ".." = "cd ..";
    c = "clear";
    cf = "clear && neofetch";
    sd = "cd && cd $(fd -t directory --hidden --exclude go/ | fzf)";
  };
in {
  imports =
    [
      ../../components/terminals/starship.nix
      ../../components/terminals/neofetch.nix
      ../../components/bash.nix
    ]
    ++ (
      if settings.usr.display.wm == "hyprland"
      then [../../components/wm/hyprland.nix]
      else if settings.usr.display.wm == "bspwm"
      then [../../components/wm/bspwm.nix]
      else []
    )
    ++ (
      if settings.usr.terminal == "kitty"
      then [../../components/terminals/kitty.nix]
      else []
    );

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"];

  home.username = settings.usr.username;
  home.homeDirectory = "/home/" + settings.usr.username;

  # You should not change this value, even if you update Home Manager
  home.stateVersion = "23.11";

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
    pkgs.ghostty

    # Theming
    pkgs.capitaine-cursors
    pkgs.la-capitaine-icon-theme
    pkgs.qogir-theme # GTK theme
    pkgs.qogir-icon-theme # Icons and cursors

    (pkgs.writeShellScriptBin "switch-system" ''
      echo "Rebuilding nixos config for: laptop"
      sudo nixos-rebuild switch --flake ~/.dotfiles#laptop
    '')
    (pkgs.writeShellScriptBin "switch-home" ''
      echo "Rebuilding home-manager config for: laptop"
      home-manager switch --flake ~/.dotfiles#laptop
    '')
  ];

  home.file = {
    "/home/aidant/.config/electron-flags.conf".text =
      if settings.usr.display.backend == "hyprland"
      then ''
        --enable-featureUseOzonePlatform --ozone-platform=wayland
      ''
      else '''';
    "/home/aidant/.wallpapers".source = ../../components/wallpapers;
    "/home/aidant/.local/share/applications".source = ../../components/applications;
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
    size = 24;
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
      size = 24;
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

  # Configure programs
  programs.bash = {
    enable = true;
    shellAliases = aliases;
    enableCompletion = true;
    initExtra = ''
      EDITOR=nvim
      clear && neofetch
    '';
  };

  programs.git = {
    enable = true;
    userEmail = "aidant@agylia.com";
    userName = "Aidan Thomas";
    aliases = {
      cl = "!f(){ git clone git@github.com:\${1} \${2}; };f";
      lg = "log --oneline --graph --decorate --all";
    };
    lfs.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "master";
      };
    };
  };

  programs.vscode = {
    enable = true;
    userSettings = {
      "window.titleBarStyle" = "custom";
    };
  };

  services.caffeine.enable = true;

  # Let home manager manage itself
  programs.home-manager.enable = true;
}
