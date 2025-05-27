{
  pkgs,
  settings,
  ...
}: let
  ewwConfig = fetchGit {
    url = "https://github.com/AidanThomas/eww-config";
    rev = "97a9e71a6dc2536a0cf4e1e41f715b8d67cc928b";
  };
in {
  programs.eww = {
    enable = true;
    configDir = pkgs.symlinkJoin {
      name = "eww";
      paths = [ewwConfig "${ewwConfig}/${settings.usr.display.wm}"];
    };
  };

  home.packages = [
    pkgs.networkmanager_dmenu
    pkgs.brightnessctl
    pkgs.socat
    pkgs.jq
    pkgs.spotify-cli-linux
    pkgs.alsa-utils
    pkgs.cava
  ];
}
