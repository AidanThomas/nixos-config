{ pkgs, usr, ... }:
{
    imports = [

    ] ++ (if usr.display.wm.statusbar == "eww" then [ ./statusbars/awesome/eww.nix ] else []);

    xsession.windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
            luarocks
            luadbi-mysql
        ];
        package = pkgs.awesome;
    };

    home.packages = [
        pkgs.rofi
        pkgs.picom
        pkgs.wmctrl
        pkgs.jq
    ];

}
