self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: rec {
    version = "v0.11.1";
    src = super.fetchurl {
      url = "https://github.com/neovim/neovim/archive/${version}.tar.gz";
      hash = "sha256-/+f5p2M+2JX/atsQOa91Fs1kU3FciImthEtvo5w99EM=";
    };
  });
}
