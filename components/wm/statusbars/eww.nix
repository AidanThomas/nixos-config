{
  pkgs,
  settings,
  ...
}: {
  programs.eww = {
    enable = true;
    configDir = pkgs.symlinkJoin {
      name = "eww";
      paths = [./eww ../scripts/eww/${settings.usr.display.wm}];
    };
  };

  home.packages = [
    pkgs.networkmanager_dmenu
    pkgs.brightnessctl
    pkgs.socat
    pkgs.jq
    pkgs.spotify-cli-linux
    pkgs.alsa-utils
  ];
}
