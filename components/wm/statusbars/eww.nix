{
  pkgs,
  settings,
  ...
}: let
  ewwConfig = fetchGit {
    url = "https://github.com/AidanThomas/eww-config";
    rev = "629cfba1ad50bf53e72c64a4b8f4eaa87077c64c";
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
