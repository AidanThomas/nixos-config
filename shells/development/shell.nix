{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
	name = "development";
	nativeBuildInputs = [
		pkgs.nodejs
	];

	shellHook = ''
	'';
}
