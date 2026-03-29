{
  pkgs,
  settings,
  ...
}: let
  ewwConfig = fetchGit {
    url = "https://github.com/AidanThomas/eww-config";
    rev = "bef314fafc7deeacee45b356243b813f2371d31e";
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
