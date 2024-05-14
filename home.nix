{ config, pkgs, ... }:
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
        ./wm/hyprland.nix
        ./terminals/kitty.nix
        ./terminals/starship.nix
    ];

	nixpkgs.config.allowUnfree = true;
    nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0"];

	home.username = "aidant";
	home.homeDirectory = "/home/aidant";

	# You should not change this value, even if you update Home Manager
	home.stateVersion = "23.11";

	home.packages = [
        pkgs.xdg-desktop-portal-hyprland
		pkgs.starship
		pkgs.firefox
		(pkgs.nerdfonts.override { fonts = [ "RobotoMono" ]; })
		pkgs.go
		pkgs.gccgo13
		pkgs.rustup
		pkgs.kitty
        pkgs.wezterm
		pkgs.cinnamon.nemo
		pkgs.discord
        pkgs.neofetch
        pkgs.gnumake
        pkgs.ripgrep
        pkgs.fd
        pkgs.wofi
        pkgs.obsidian
        pkgs.discord
        pkgs.dunst
        pkgs.libnotify
        pkgs.socat
        pkgs.jq
        pkgs.wl-clipboard
        pkgs.grim
        pkgs.slurp

		# Theming
		pkgs.capitaine-cursors
		pkgs.la-capitaine-icon-theme
		pkgs.qogir-theme # GTK theme
		pkgs.qogir-icon-theme # Icons and cursors
		pkgs.lxappearance

		# Set virtual machine resolution - Change monitor name accordingly
		(pkgs.writeShellScriptBin "set-resolution" ''
			xrandr --newmode "2560x1440_60.00"  312.25  2560 2752 3024 3488  1440 1443 1448 1493 -hsync +vsync
			xrandr --addmode Virtual-1 "2560x1440_60.00"
			xrandr -s 2560x1440
		'')
	];

    # Window manager

	home.file = {
        "/home/aidant/.config/electron-flags.conf".text = ''
            --enable-featureUseOzonePlatform --ozone-platform=wayland
        '';
        "/home/aidant/.wallpapers".source = ./wallpapers;
    };

	# Configure X
	xsession = {
		enable = true;
	};
	xresources = {
		properties = {
			"Xft.dpi" = 162; # Calculate using https://dpi.lv/
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

	# Configure services
	services.picom = {
		enable = true;
		backend = "glx";

		shadow = true;
		shadowOpacity = 0.75;
		shadowOffsets = [ (-7) (-7) ];
		shadowExclude = [
			"name = 'Notification'"
			"class_g = 'Conky'"
			"class_g ?= 'Notify-osd'"
			"class_g = 'Cairo-clock'"
			"class_g = 'awesome'"
			"_GTK_FRAME_EXTENTS@:c"
		];

		fade = true;
		fadeSteps = [ 0.03 0.03 ];
		fadeDelta = 5;

		inactiveOpacity = 0.9;
		activeOpacity = 1.0;
		opacityRules = [
			"100:class_g = 'firefox'"
			"100:class_g = 'Google-chrome'"
			"85:class_g = 'Spotify' && !focused"
			"95:class_g = 'Spotify' && !focused"
			"80:class_g = 'kitty' && !focused"
			"90:class_g = 'kitty' && focused"
		];

		settings = {
			blur = {
				method = "dual_kawase";
				strength = 4;
			};
		};

		extraArgs = [
			"--blur-background"
		];
	};

	# Configure programs
	programs.bash = {
		enable = true;
		shellAliases = aliases;
        enableCompletion = true;
        initExtra = "EDITOR=nvim\nNIXOS_OZONE_WL=1";
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

	programs.rofi = {
		enable = true;
		font = "RobotoMono Nerd Font 12";
		extraConfig = {
			modi = "window,drun,run,ssh";
			show-icons = true;
		};
		theme =
		let
			inherit (config.lib.formats.rasi) mkLiteral;
		in{
			"*" = {
				bg-dark = mkLiteral "#16161e";
				bg = mkLiteral "#1a1b26";
				bg-highlight = mkLiteral "#292e42";
				terminal-black = mkLiteral "#414868";
				fg = mkLiteral "#c0caf5";
				fg-dark = mkLiteral "#a9b1d6";
				fg-gutter = mkLiteral "#3b4261";
				dark3 = mkLiteral "#545c7e";
				comment = mkLiteral "#565f89";
				dark5 = mkLiteral "#737aa2";
				blue0 = mkLiteral "#3d59a1";
				blue = mkLiteral "#7aa2f7";
				cyan = mkLiteral "#7dcfff";
				blue1 = mkLiteral "#2ac3de";
				blue2 = mkLiteral "#0db9d7";
				blue5 = mkLiteral "#89ddff";
				blue6 = mkLiteral "#b4f9f8";
				blue7 = mkLiteral "#394b70";
				magenta = mkLiteral "#bb9af7";
				magenta2 = mkLiteral "#ff007c";
				purple = mkLiteral "#9d7cd8";
				orange = mkLiteral "#ff9e64";
				yellow = mkLiteral "#e0af68";
				green = mkLiteral "#9ece6a";
				green1 = mkLiteral "#73daca";
				green2 = mkLiteral "#41a6b5";
				teal = mkLiteral "#1abc9c";
				red = mkLiteral "#f7768e";
				red1 = mkLiteral "#db4b4b";

				accent = mkLiteral "@blue1";
				urgent = mkLiteral "@yellow";

				background-color = mkLiteral "@bg";
				text-color = mkLiteral "@fg";

				margin = 0;
				padding = 0;
				spacing = 0;
			};
			"element-icon, element-text, scrollbar" = {
				cursor = mkLiteral "pointer";
			};
			"window" = {
				location = mkLiteral "north";
				width = mkLiteral "500px";
				x-offset = mkLiteral "0px";
				y-offset = mkLiteral "100px";
				bacground-color = mkLiteral "@bg";
				border = mkLiteral "1px";
				border-color = mkLiteral "@bg-highlight";
				border-radius = mkLiteral "0px";
			};
			"inputbar" = {
				spacing = mkLiteral "8px";
				padding = mkLiteral "4px 8px";
				children = map mkLiteral [ "icon-search" "entry" ];

				background-color = mkLiteral "@bg";
			};
			"icon-search, entry, element-icon, element-text" = {
				vertical-align = mkLiteral "0.5";
			};
			"icon-search" = {
				expand = false;
				filename = "search-symbolic";
				size = mkLiteral "20px";
			};
			"textbox" = {
				padding = mkLiteral "4px 8px";
				background-color = mkLiteral "@bg";
			};
			"listview" = {
				padding = mkLiteral "4px 0px";
				lines = 12;
				columns = 1;
				scrollbar = true;
				fixed-height = true;
				dynamic = true;
			};
			"element" = {
				padding = mkLiteral "4px 8px";
				spacing = mkLiteral "8px";
			};

			"element normal urgent" = {
				text-color = mkLiteral "@urgent";
			};

			"element normal active" = {
				text-color = mkLiteral "@accent";
			};
			"element selected" = {
				text-color = mkLiteral "@bg";
				background-color = mkLiteral "@accent";
			};
			"element-text selected" = {
				text-color = mkLiteral "@bg";
				background-color = mkLiteral "@accent";
			};
			"element-icon selected" = {
				background-color = mkLiteral "@accent";
			};
			"element selected urgent" = {
				background-color = mkLiteral "@urgent";
			};
			"element-icon" = {
				size = mkLiteral "0.8em";
			};
			"element-text" = {
				text-color = mkLiteral "inherit";
			};
			"scrollbar" = {
				handle-width = mkLiteral "4px";
				handle-color = mkLiteral "@fg";
				padding = mkLiteral "0 4px";
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
