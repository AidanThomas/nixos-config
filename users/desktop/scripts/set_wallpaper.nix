{pkgs, ...}: {
  home.packages = [
    pkgs.xwallpaper
    (pkgs.writeShellScriptBin "set_wallpapers" ''
      if [ "$XDG_SESSION_TYPE" == "x11" ]; then
        xwallpaper --output DP-0 --zoom /home/aidant/.wallpapers/dawn-lake.jpg
        xwallpaper --output DP-4 --zoom /home/aidant/.wallpapers/dawn-lake.jpg
      # elif [ "$XDG_SESSION_TYPE" == "wayland" ]; the
      fi
    '')
  ];
}
