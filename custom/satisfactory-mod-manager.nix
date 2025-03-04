{pkgs}: let
  pname = "SatisfactoryModManager";
  version = "v3.0.3";

  src = pkgs.fetchurl {
    url = "https://github.com/satisfactorymodding/SatisfactoryModManager/releases/download/${version}/${pname}_linux_amd64.AppImage";
    hash = "sha256-PN9IqGZSLgug6YgAgNKMmSX0VlgBGc/Aj1YqkPHqLRY=";
  };
in
  pkgs.appimageTools.wrapType2 {
    inherit pname version src;
  }
