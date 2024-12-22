{ config, ... }:
{
  # Enable VirtualBox
  virtualisation.virtualbox = {
    host.enable = true;

    # Enable the VirtualBox guest additions
    guest = {
      enable = true;

      # Enable the clipboard and drag-and-drop features
      dragAndDrop = true;

      # Enable the shared clipboard feature
      clipboard = true;
    };
  };

  # Add the current user to the vboxusers group
  users.extraGroups.vboxusers.members = [ "${config.users.default.username}" ];
}
