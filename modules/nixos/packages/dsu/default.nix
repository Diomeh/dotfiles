{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  pname = "dsu";
  version = "2.1.30";
  src = pkgs.fetchurl {
    url = "https://github.com/Diomeh/dsu/releases/download/v2.2.9/dsu-v2.2.9.tar.gz";
    sha256 = "08b242lvmn2lclb6nacifivhlwamybzq88mccik5ygrxh24zx3wr";
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
