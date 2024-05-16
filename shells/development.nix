{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
	name = "development";
	nativeBuildInputs = [
		pkgs.nodejs
		pkgs.dotnet-sdk_8
		pkgs.rustup
		pkgs.go
		pkgs.gccgo13
        pkgs.gnumake
	];

	shellHook = ''
        rustupd default stable
	'';
}
