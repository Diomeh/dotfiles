{ lib, config, ... }:
{
  # Enable docker daemon
  # This does not enables docker desktop as it is not available on NixOS.
  # A good alternative is portainer, see https://www.portainer.io
  virtualisation.docker.enable = true;

  # Add the current user to the docker group
  users.users."${config.users.default.username}".extraGroups = [ "docker" ];

  # Force disable docker service so that it is not started at boot
  systemd.services.docker.wantedBy = lib.mkForce [];
}
