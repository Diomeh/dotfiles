{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "custom-scripts";
  version = "0.1.5";
  src = ./src;
  dontBuild = true;

  # Binaries required by the scripts
  buildInputs = with pkgs; [
    xclip # copy, paste
    p7zip # xtract
    unzip # xtract
    unrar # xtract
  ];

  installPhase = ''
    mkdir -p $out/bin
    install --mode +x -t $out/bin ./*
  '';
}
