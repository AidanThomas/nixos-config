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
	nixpkgs.config.allowUnfree = true;

	home.username = "aidant";
	home.homeDirectory = "/home/aidant";

	# You should not change this value, even if you update Home Manager
	home.stateVersion = "23.11";

	home.packages = [
		pkgs.starship
		pkgs.firefox
		(pkgs.nerdfonts.override { fonts = [ "RobotoMono" ]; })
		pkgs.go
		pkgs.gccgo13
		pkgs.rustup
		pkgs.kitty
		pkgs.cinnamon.nemo
		#pkgs.google-chrome

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

	home.file = {};

	home.sessionVariables = {
		EDITOR = "nvim";
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

	# Configure services
	services.picom = {
		enable = false;
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
	};

	programs.starship = {
		enable = true;
		enableBashIntegration = true;
		enableZshIntegration = true;
		settings = {
			format = builtins.concatStringsSep "" [
				"[  ](bg:#a3aed2 fg:#090c0c)"
				"$nix_shell"
				"[](bg:#769ff0 fg:#a3aed2)"
				"$directory"
				"[](fg:#769ff0 bg:#394260)"
				"$git_branch"
				"$git_status"
				"[](fg:#394260 bg:#1d2230)"
				"$time"
				"[ ](fg:#1d2230)"
				"$line_break"
				"$character"
			];
			add_newline = false;
			character = {
				success_symbol = "[ 󰜴](bold green)";
				error_symbol = "[ 󰜴](bold red)";
			};
			directory = {
				style = "bold fg:#1a1b26 bg:#769ff0";
				format = "[ $path ]($style)";
				truncation_length = 3;
				truncation_symbol = "…/";
			};
			git_branch = {
				symbol = "";
				style = "bg:#394260";
				format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
			};
			git_status = {
				style = "bg:#394260";
				format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
			};
			time = {
				disabled = false;
				time_format = "%R"; # Hour:Minute format
				style = "bg:#1d2230";
				format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
			};
			nix_shell = {
				disabled = false;
				style = "bold bg:#a3aed2 fg:#090c0c";
				format = "[ (\($name\)) ]($style)";
			};
		};
	};

	programs.git = {
		enable = true;
		userEmail = "aidant@agylia.com";
		userName = "Aidan Thomas";
		aliases = {
			cl = "!f(){ git clone git@github.com:\${1} \${2}; };f";
		};
	};

	programs.kitty = {
		enable = true;
		font = {
			name = "RobotoMono Nerd Font";
			size = 12;
		};
		shellIntegration = {
			enableBashIntegration = true;
			enableZshIntegration = true;
		};
		theme = "Tokyo Night";
		settings = {
			background_opacity = "1.0";
			confirm_os_window_close = 0;
			window_border_width = 0;
			window_padding_width = 0;
			window_padding_height = 0;
		};
	};

	programs.tmux = {
		enable = true;
		keyMode = "vi";
		mouse = true;
		newSession = true;
		prefix = "C-b";
		extraConfig = builtins.concatStringsSep "\n" [
			"set -g default-terminal \"screen-256color\""
			"set -as terminal-features \",kitty*:RGB\" "
			"set -as terminal-overrides ',*:mulx=\E[4::%p1%dm' # Undercurl support"
			"set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0"
			"set -g mode-style \"fg=#7aa2f7,bg=#3b4261\""
			"set -g message-style \"fg=#7aa2f7,bg=#3b4261\""
			"set -g message-command-style \"fg=#7aa2f7,bg=#3b4261\""
			"set -g pane-border-style \"fg=#3b4261\""
			"set -g pane-active-border-style \"fg=#7aa2f7\""
			"set -g status \"on\""
			"set -g status-justify \"left\""
			"set -g status-style \"fg=#7aa2f7,bg=#16161e\""
			"set -g status-left-length \"100\""
			"set -g status-right-length \"100\""
			"set -g status-left-style NONE"
			"set -g status-right-style NONE"
			"set -g status-left \"#[fg=#15161e,bg=#7aa2f7,bold] #S #[fg=#7aa2f7,bg=#16161e,nobold,nounderscore,noitalics]\""
			"set -g status-right \"#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#16161e] #{prefix_highlight} #[fg=#3b4261,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] %Y-%m-%d  %I:%M %p #[fg=#7aa2f7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#15161e,bg=#7aa2f7,bold] #h \""
			"if-shell '[ \"$(tmux show-option -gqv \"clock-mode-style\")\" == \"24\" ]' {"
			  "set -g status-right \"#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#16161e] #{prefix_highlight} #[fg=#3b4261,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] %Y-%m-%d  %H:%M #[fg=#7aa2f7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#15161e,bg=#7aa2f7,bold] #h \""
			"}"
			"setw -g window-status-activity-style \"underscore,fg=#a9b1d6,bg=#16161e\""
			"setw -g window-status-separator """
			"setw -g window-status-style \"NONE,fg=#a9b1d6,bg=#16161e\""
			"setw -g window-status-format \"#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]\""
			"setw -g window-status-current-format \"#[fg=#16161e,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#16161e,nobold,nounderscore,noitalics]\""
			"set -g @prefix_highlight_output_prefix \"#[fg=#e0af68]#[bg=#16161e]#[fg=#16161e]#[bg=#e0af68]\""
			"set -g @prefix_highlight_output_suffix \"\""
			"set -g default-terminal \"\${TERM}\""
			"set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support"
			"set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0"
		];
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

	# Let home manager manage itself
	programs.home-manager.enable = true;
}
