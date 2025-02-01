{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  name = "development";
  nativeBuildInputs = [
    pkgs.nodejs
    pkgs.dotnet-sdk_8
    pkgs.postgresql
  ];

  shellHook = ''
    rustup default stable
  '';
}
