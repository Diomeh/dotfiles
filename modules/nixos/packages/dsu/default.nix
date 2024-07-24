{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  pname = "dsu";
  version = "2.1.30";
  src = pkgs.fetchurl {
    url = "https://github.com/Diomeh/dsu/releases/download/v2.2.0/dsu-v2.2.0.tar.gz";
    sha256 = "00nhds6cj02h12jyc04800y1fngl50d79cs2cd2mw2wss2lvzwvf";
  };

  installPhase = ''
    mkdir -p $out/bin
    tar xzf $src -C $out/bin --strip-components=1 bin
  '';

  # error: attribute 'lib' missing
  # meta = with pkgs.stdenv.lib; {
  #   description = "Diomeh's Scripts Utilities";
  #   license = licenses.mit;
  #   maintainers = [ ];
  # };
}
