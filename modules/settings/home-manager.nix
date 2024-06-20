{ inputs, ... }:
let
  # TODO: read user from a separate file
  username = "diomeh";
  hostname = "victus16d00";
in
{
  # home-manager configuration
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "${username}" = import ../../hosts/${hostname}/home.nix;
    };
  };
}
