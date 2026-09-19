{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  hyprland = inputs.hyprland.packages.${system}.hyprland.override {
    glaze-hyprland = pkgs.glaze;
  };
  hyprlandPlugins = pkgs.hyprlandPlugins.override {inherit hyprland;};
  hyprglass = hyprlandPlugins.mkHyprlandPlugin {
    pluginName = "hyprglass";
    version = "unstable-${inputs.hyprglass.shortRev or "unknown"}";
    src = inputs.hyprglass;

    installPhase = ''
      runHook preInstall
      install -Dm755 hyprglass.so "$out/lib/libhyprglass.so"
      runHook postInstall
    '';

    meta = {
      description = "Liquid Glass window decoration effect for Hyprland";
      homepage = "https://github.com/hyprnux/hyprglass";
      license = pkgs.lib.licenses.bsd3;
      platforms = pkgs.lib.platforms.linux;
    };
  };
in {
  imports = [
    # ./statusbars/${settings.usr.display.statusbar}.nix

    ../programs/hyprlock.nix
    ../programs/rofi.nix

    ../services/hyprpaper.nix
    ../services/swayosd.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    package = hyprland;
    portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
    extraConfig = ''
      -- Keep plugin loading in the Nix-generated entry point so the store path
      -- is retained in the Home Manager closure. Loading causes Hyprland to
      -- re-evaluate the config, at which point its Lua API is available.
      hl.plugin.load("${hyprglass}/lib/libhyprglass.so")
      dofile("${config.home.homeDirectory}/dev/AidanThomas/hyprland-config/hyprland.lua")
    '';
  };

  xdg.dataFile."hypr/stubs".source = "${hyprland}/share/hypr/stubs";

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
    pkgs.cava
    pkgs-unstable.hyprshutdown
  ];

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
