{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellScriptBin "position_monitors" ''
      if [ "$XDG_SESSION_TYPE" == "x11" ]; then
        xrandr --output DP-0 --mode 2560x1440 --rate 165.00 --auto
        xrandr --output DP-2 --mode 2560x1440 --rate 165.00 --primary --right-of DP-0
        xrandr --output DP-4 --mode 2560x1440 --rate 165.00 --right-of DP-2
      # elif [ "$XDG_SESSION_TYPE" == "wayland" ]; then
      fi
    '')
  ];
}
