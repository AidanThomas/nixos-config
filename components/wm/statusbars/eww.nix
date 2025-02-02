{pkgs, ...}: {
  programs.eww = {
    enable = true;
    configDir = ./eww;
  };

  home.packages = [
    pkgs.networkmanager_dmenu
    pkgs.brightnessctl
    pkgs.socat
    pkgs.jq
    pkgs.spotify-cli-linux
    pkgs.alsa-utils
  ];

  home.file = {
    "/home/aidant/.config/networkmanager-dmenu/config.ini".text = ''
      [dmenu]
      dmenu_command = rofi -show drun
    '';
    "/home/aidant/.config/eww/scripts".source = ../scripts/eww/bspwm/scripts;
  };
}
