{ config, pkgs, ... }:

let
  # Remember to update the hash when the version changes
  # nurl https://github.com/Diomeh/nix-xdm <VERSION>
  xdm = pkgs.fetchFromGitHub {
    owner = "Diomeh";
    repo = "nix-xdm";
    rev = "0.0.1";
    hash = "sha256-uME0V2thw0ANiqAgFHnSlPWG7Lg3iR1QLkcsFdQ0bT8=";
  };
in
{
  environment.systemPackages = [
    # Custom XDM (Xtreme Download Manager) derivation
    (pkgs.callPackage "${xdm}/derivation.nix" { inherit pkgs; })
  ];
}
