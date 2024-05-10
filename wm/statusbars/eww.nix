{ pkgs, ... }:
{
    programs.eww = {
        enable = true;
        package = pkgs.eww-wayland;
        configDir = ./eww;
    };

    home.packages = [
        pkgs.networkmanager_dmenu
        pkgs.brightnessctl
    ];

    home.file = {
        "/home/aidant/.config/networkmanager-dmenu/config.ini".text = ''
        [dmenu]
        dmenu_command = wofi --dmenu
        '';
    };
}
