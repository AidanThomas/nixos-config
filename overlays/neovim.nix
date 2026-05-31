self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: rec {
    version = "v0.12.2";
    src = super.fetchurl {
      url = "https://github.com/neovim/neovim/archive/${version}.tar.gz";
      hash = "sha256-759Y2n1oftTR2tlxVUK/Dave7b/oCJ4s4X//Ibkgomg=";
    };
  });
}
