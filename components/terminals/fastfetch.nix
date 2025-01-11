{...}: {
  programs.fastfetch = {
    enable = true;
  };

  home.file = {
    "/home/aidant/.config/fastfetch".source = ../../components/symlinks/config/fastfetch;
  };
}
