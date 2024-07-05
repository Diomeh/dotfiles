{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  pname = "dsu";
  version = "2.1.30";
  src = pkgs.fetchurl {
    url = "https://github.com/Diomeh/dsu/releases/download/v2.1.30/dsu-v2.1.30.tar.gz";
    sha256 = "0lw8gym80bpgdbb6kxrsm85hr374h03k5jmfijy34r5b0cp3hrm7";
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
