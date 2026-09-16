{
  fetchFromGitHub,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "protomolecule";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "ThinkDualBrain";
    repo = "Protomolecule";
    rev = "master";
    hash = "sha256-P/7n2kPP4yeKQHlon+jOVlyjJYa4Bp5ZiZozJJJJmBQ=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 Protomolecule.otf \
      $out/share/fonts/opentype/Protomolecule.otf

    runHook postInstall
  '';
}
