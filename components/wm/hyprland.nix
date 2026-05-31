{
  config,
  pkgs,
  settings,
  inputs,
  ...
}: {
  imports = [
    ./statusbars/${settings.usr.display.statusbar}.nix

    ../programs/hyprlock.nix
    ../programs/rofi.nix

    ../services/hyprpaper.nix
    ../services/swaync.nix
    ../services/swayosd.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
    extraConfig = ''
      # Main Hyprland config is managed by hyprland.lua
    '';
  };

  xdg.dataFile."hypr/stubs".source = "${inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/share/hypr/stubs";

  xdg.configFile."hypr/hyprland.lua".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dev/AidanThomas/hyprland-config/hyprland.lua";
  xdg.configFile."hypr/lua".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dev/AidanThomas/hyprland-config/lua";

  home.packages = [
    pkgs.wl-clipboard
    pkgs.grim
    pkgs.slurp
    pkgs.egl-wayland
    pkgs.spotify-cli-linux
    pkgs.hyprshot
    pkgs.playerctl
  ];

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
