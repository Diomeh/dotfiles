{ inputs, pkgs, ... }:
let
  # TODO: read user from a separate file
  username = "diomeh";
  hostname = "victus16d00";
in
{
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  # home-manager configuration
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "${username}" = import ../../hosts/${hostname}/home.nix;
    };
  };
}
