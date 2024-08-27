{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  pname = "dsu";
  version = "2.1.30";
  src = pkgs.fetchurl {
    url = "https://github.com/Diomeh/dsu/releases/download/2.2.10/dsu-2.2.10.tar.gz";
    sha256 = "0l6xw6lpvsx6f4xjiz0g55r7zgwjwk110rg0x0d3kqx9jx47rfz7";
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
