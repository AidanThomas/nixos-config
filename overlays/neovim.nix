self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: rec {
    version = "v0.12.5";
    src = super.fetchurl {
      url = "https://github.com/neovim/neovim/archive/${version}.tar.gz";
      hash = "sha256-qBDJUzIxe9ABfhygfjdqhHLHkHXL7QD6NzfRkKigpFo=";
    };
  });
}
