{ ... }:
{
  # Enable docker daemon
  # This does not enables docker desktop as it is not available on NixOS.
  # A good alternative is portainer, see https://www.portainer.io
  virtualisation.docker.enable = true;

  # Add the current user to the docker group
  # TODO: move user to a separate file
  users.users.diomeh.extraGroups = [ "docker" ];
}
