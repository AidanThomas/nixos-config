# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, sys, ... }:

{
	imports = [ ./hardware-configuration.nix ];

    boot.loader.grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
    };
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages;

	networking.hostName = sys.hostname;
	networking.hosts = {
		"192.168.1.254" = [ "router.admin.com" ];
		"192.168.122.243" = [
			"providers.local.com"
			"services.local.com"
			"admin.local.com"
			#"aidan.portal-agylia.com"
		];
	};

	networking.networkmanager.enable = true;

	time.timeZone = "Europe/London";

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

	hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
	};

    hardware.nvidia = (if sys.hardware.nvidia then {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = false;
        package = config.boot.kernelPackages.nvidiaPackages.production;
    } else {});

	services.xserver = {
		enable = true;
		videoDrivers = [ ] ++ (if sys.hardware.nvidia then [ "nvidia" ] else []);

        windowManager.awesome = {
            enable = true;
            luaModules = with pkgs.luaPackages; [
                luarocks
                luadbi-mysql
            ];
        };

        desktopManager.gnome.enable = true;
	};

    services.displayManager = {
        sddm.enable = true;
        defaultSession = "none+awesome";
    };

	sound.enable = true;
    hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		# jack.enable = true;
	};

	environment.shells = with pkgs; [ bash zsh ];
	users.defaultUserShell = pkgs.bash;

	services.xserver = {
        xkb = {
            layout = "gb";
            variant = "";
        };
	};

	console.keyMap = "uk";

	users.users.aidant = {
		isNormalUser = true;
		description = "Aidan Thomas";
		extraGroups = [ "networkmanager" "wheel" "docker" ];
		packages = []; 
	};

    users.users.nixosvmtest = {
      isSystemUser = true;
      initialPassword = "test";
    };

    users.users.nixosvmtest.group = "nixosvmtest";
    users.groups.nixosvmtest = {};

	nixpkgs.config.allowUnfree = true;
	nixpkgs.config.allowUnfreePredicate = _: true;

	environment.systemPackages = [
		pkgs.neovim
		pkgs.wget
		pkgs.git
        pkgs.firefox
        pkgs.libnotify
	];

	virtualisation.docker = {
		enable = true;
	};

	system.stateVersion = "23.11";
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
