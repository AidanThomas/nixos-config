{
  config,
  pkgs,
  settings,
  inputs,
  system,
  ...
}: {
  imports = [./hardware-configuration.nix];

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = true;
    efiSupport = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages;
  boot.loader.timeout = -1;

  networking.hostName = settings.sys.hostname;
  networking.hosts = {
    "192.168.1.1" = ["admin.router.com"];
    "192.168.1.135" = [
      # "assist.pi.home"
      "providers.local.com"
      "services.local.com"
      "admin.local.com"
    ];
  };
  networking.nameservers = [
    "192.168.1.111"
    "192.168.1.1"
    "8.8.8.8"
  ];

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

  hardware.graphics.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];

    windowManager.bspwm.enable =
      if settings.usr.display.wm == "bspwm"
      then true
      else false;
  };

  programs.hyprland =
    if settings.usr.display.wm == "hyprland"
    then {
      enable = true;
      package = inputs.hyprland.packages.${system}.hyprland;
      xwayland.enable = true;
    }
    else {};

  # Wayland stuff for running Hyprland
  environment.sessionVariables =
    if settings.usr.display.wm == "hyprland"
    then {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    }
    else {};

  services.displayManager = {
    sddm.enable = true;
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    audio.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };
  programs.noisetorch.enable = true;

  environment.shells = with pkgs; [bash zsh];
  users.defaultUserShell = pkgs.bash;

  services.xserver = {
    xkb = {
      layout = settings.usr.kb.layout;
      variant = "";
    };
  };

  console.keyMap = settings.usr.kb.keymap;

  users.users.aidant = {
    isNormalUser = true;
    description = "Aidan Thomas";
    extraGroups = ["networkmanager" "wheel" "docker"];
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

  programs.dconf.enable = true;
  programs.steam.enable = true;

  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      insecure-registries = ["192.168.1.111:5000"];
    };
  };

  system.stateVersion = "24.05";
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
