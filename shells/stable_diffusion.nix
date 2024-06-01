{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  name = "stable_diffusion";
  nativeBuildInputs = [
    pkgs.gccgo13
    pkgs.python3
  ];

  shellHook = ''
    cd ~/personal/stable-diffusion-webui
    ./webui.sh
  '';
}
