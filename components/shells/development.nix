{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  name = "development";
  nativeBuildInputs = [
    pkgs.nodejs
    pkgs.dotnet-sdk_8
  ];

  shellHook = ''
    rustup default stable
  '';
}
