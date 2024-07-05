{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  pname = "dsu";
  version = "2.1.24";
  src = pkgs.fetchurl {
    url = "https://github.com/Diomeh/dsu/releases/download/v2.1.24/dsu-v2.1.24.tar.gz";
    sha256 = "1ginq9nn930cwm9hkblyps70nr5x9zbkpqh0z7n6drqpmh4hp37w";
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
