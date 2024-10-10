{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  pname = "dsu";
  version = "2.1.30";
  src = pkgs.fetchurl {
    url = "https://github.com/Diomeh/dsu/releases/download/2.2.12/dsu.tar.gz";
    sha256 = "1ip0a950r13935ap9vc2d6pdjg7bcp2vmw2sa7wkim9mimscmkbb";
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
