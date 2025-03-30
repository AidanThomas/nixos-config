self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: rec {
    version = "v0.11.0";
    src = super.fetchurl {
      url = "https://github.com/neovim/neovim/archive/${version}.tar.gz";
      hash = "sha256-aCbEgS6WmV0pqYWG1E++58myBFSF1Q0XS+zW1SQrMxk=";
    };
    # src = super.fetchFromGitHub {
    #   owner = "neovim";
    #   repo = "neovim";
    #   rev = "release-0.11";
    #   sha256 = "3684KPUTq7ZBluJvvUnywIgDcUwJ6NAtlFxh5pkE0Cg=";
    # };
  });
}
