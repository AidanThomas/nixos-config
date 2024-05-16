{ pkgs, usr, ... }:
let
	aliases = {
		switch-system = "sudo nixos-rebuild switch --flake ~/.dotfiles";
		switch-home = "home-manager switch --flake ~/.dotfiles";
		develop = "nix develop ~/.dotfiles#development";

		ll = "ls -la";
		".." = "cd ..";
		c = "clear";
		".dotfiles" = "cd ~/.dotfiles";
		".config" = "cd ~/.config";
	};
in {
    imports = [ 
        ./terminals/starship.nix
    ] ++ (if usr.display.wm.name == "hyprland" then [ ./wm/hyprland.nix ] else [])
      ++ (if usr.terminal == "kitty" then [ ./terminals/kitty.nix] else []);

	nixpkgs.config.allowUnfree = true;
    nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0"];

	home.username = usr.username;
	home.homeDirectory = "/home/" + usr.username;

	# You should not change this value, even if you update Home Manager
	home.stateVersion = "23.11";

	home.packages = [
        # Font
		(pkgs.nerdfonts.override { fonts = [ "RobotoMono" ]; })

        # Extra
		pkgs.cinnamon.nemo
		pkgs.discord
        pkgs.neofetch
        pkgs.ripgrep
        pkgs.fd
        pkgs.obsidian
        pkgs.discord

		# Theming
		pkgs.capitaine-cursors
		pkgs.la-capitaine-icon-theme
		pkgs.qogir-theme # GTK theme
		pkgs.qogir-icon-theme # Icons and cursors
	];

	home.file = {
        "/home/aidant/.config/electron-flags.conf".text = (if usr.display.backend == "hyprland" then ''
            --enable-featureUseOzonePlatform --ozone-platform=wayland
        '' else '''');
        "/home/aidant/.wallpapers".source = ./wallpapers;
    };

	# Configure X
	xsession = {
		enable = true;
	};
	xresources = {
		properties = {
			"Xft.dpi" = usr.display.dpi;
		};
	};
	home.pointerCursor = {
		# Themes:
		# - capitaine-cursors
		# - Qogir
		# - Qogir-dark
		name = "Qogir";
		package = pkgs.qogir-icon-theme;
		size = usr.theme.cursorSize;
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
			size = usr.theme.cursorSize;
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
            NIXOS_OZONE_WL=1
            clear && neofetch
        '';
	};


	programs.git = {
		enable = true;
		userEmail = "aidant@agylia.com";
		userName = "Aidan Thomas";
		aliases = {
			cl = "!f(){ git clone git@github.com:\${1} \${2}; };f";
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


	# Let home manager manage itself
	programs.home-manager.enable = true;
}
