{pkgs, ...}: {
  programs.eww = {
    enable = true;
    package = pkgs.eww;
    configDir = ./eww;
  };

  home.packages = [
    pkgs.networkmanager_dmenu
    pkgs.brightnessctl
    pkgs.socat
    pkgs.jq
  ];

  home.file = {
    "/home/aidant/.config/networkmanager-dmenu/config.ini".text = ''
      [dmenu]
      dmenu_command = rofi -show drun
    '';
  };
}
