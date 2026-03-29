self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: rec {
    version = "v0.11.7";
    src = super.fetchurl {
      url = "https://github.com/neovim/neovim/archive/${version}.tar.gz";
      hash = "sha256-tVCw5M0qD5VYvGsnjSfke1KPdoTvoqRt70OPzWTumCI=";
    };
  });
}
