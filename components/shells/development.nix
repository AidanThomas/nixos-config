{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  name = "development";
  nativeBuildInputs = [
    pkgs.nodejs
    pkgs.postgresql
  ];

  shellHook = ''
    rustup default stable
  '';
}
