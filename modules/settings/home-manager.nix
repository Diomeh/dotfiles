{ inputs, ... }:
{
  # home-manager configuration
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      # TODO: read user from a separate file
      "diomeh" = import ../../hosts/victus16d00/home.nix;
    };
  };
}
