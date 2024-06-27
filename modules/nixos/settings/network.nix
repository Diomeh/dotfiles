{ pkgs, ... }:
let
  username = "diomeh";
in
{
  # Enables wireless support via wpa_supplicant.
  # networking.wireless.enable = true;  

  # IPV6 fails to connect and is unreachable from https://ipleak.net/, disable it for lack of better solution for now.
  networking.enableIPv6 = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Add the current user to the docker group
  # TODO: move user to a separate file
  users.users."${username}".extraGroups = [ "networkmanager" ];
}
