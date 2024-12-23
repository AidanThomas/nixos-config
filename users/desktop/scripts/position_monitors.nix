{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellScriptBin "position_monitors" ''
      if [ "$XDG_SESSION_TYPE" == "x11" ]; then
        xrandr --output DP-0 --mode 2560x1440 --rate 165.00 --primary --auto
        xrandr --output DP-4 --mode 2560x1440 --rate 165.00 --right-of DP-0 --rotate right
      # elif [ "$XDG_SESSION_TYPE" == "wayland" ]; then
      fi
    '')
  ];
}
