# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports = [ ./hardware-configuration.nix ];

	# Bootloader.
	# boot.loader.grub.enable = true;
	# boot.loader.grub.device = "/dev/vda";
	# boot.loader.grub.useOSProber = true;
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nixos"; # Define your hostname.
	networking.hosts = {
		"192.168.1.254" = [ "router.admin.com" ];
		"192.168.122.243" = [
			"providers.local.com"
			"services.local.com"
			"admin.local.com"
			#"aidan.portal-agylia.com"
		];
	};
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "Europe/London";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_GB.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_GB.UTF-8";
		LC_IDENTIFICATION = "en_GB.UTF-8";
		LC_MEASUREMENT = "en_GB.UTF-8";
		LC_MONETARY = "en_GB.UTF-8";
		LC_NAME = "en_GB.UTF-8";
		LC_NUMERIC = "en_GB.UTF-8";
		LC_PAPER = "en_GB.UTF-8";
		LC_TELEPHONE = "en_GB.UTF-8";
		LC_TIME = "en_GB.UTF-8";
	};

	# Enable OpenGL
	hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
	};

	services.xserver = {
		enable = true;
		videoDrivers = [ "nvidia" ];

		displayManager = {
			sddm.enable = true;
			defaultSession = "none+awesome";
		};
		
		windowManager.awesome = {
			enable = true;
			package = pkgs.awesome.overrideAttrs (old: {
				version = "e6f5c7980862b7c3ec6c50c643b15ff2249310cc";
				src = pkgs.fetchFromGitHub {
					owner = "awesomeWM";
					repo = "awesome";
					rev = "e6f5c7980862b7c3ec6c50c643b15ff2249310cc";
					sha256 = "sha256-afviu5b86JDWd5F12Ag81JPTu9qbXi3fAlBp9tv58fI=";
				};
				patches = [ ];
				postPatch = ''
					patchShebangs tests/examples/_postprocess.lua
				'';
			});
			luaModules = with pkgs.luaPackages; [
				luarocks
				luadbi-mysql
			];
		};
	};

	hardware.nvidia = {
		# Modesetting is required
		modesetting.enable = true;

		powerManagement.enable = false;
		powerManagement.finegrained = false;

		# Don't use the open source kernel module
		open = false;

		# Enable the Nvidia settings menu (`nvidia-settings`)
		nvidiaSettings = true;

		package = config.boot.kernelPackages.nvidiaPackages.production;
	};

	sound.enable = true;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};

	# Configure default shells
	environment.shells = with pkgs; [ bash zsh ];
	users.defaultUserShell = pkgs.bash;

	# Configure keymap in X11
	services.xserver = {
		layout = "gb";
		xkbVariant = "";
	};

	# Configure console keymap
	console.keyMap = "uk";

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.aidant = {
		isNormalUser = true;
		description = "Aidan Thomas";
		extraGroups = [ "networkmanager" "wheel" "docker" ];
		packages = with pkgs; [];
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;
	nixpkgs.config.allowUnfreePredicate = _: true;

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		neovim
		wget
		git
		dconf
	];

	virtualisation.docker = {
		enable = true;
	};

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
		# enable = true;
		# enableSSHSupport = true;
	# };

	# List services that you want to enable:

	# Enable the OpenSSH daemon.
	# services.openssh.enable = true;

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.11"; # Did you read the comment?

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
