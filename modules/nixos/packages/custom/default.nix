{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  pname = "custom-scripts";
  version = "0.1.5";
  src = ./src;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    install --mode +x -t $out/bin ./*
  '';
}
