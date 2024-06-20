{ ... }:
{
  # Enable VirtualBox
  virtualisation.virtualbox = {
    host.enable = true;

    # Enable the VirtualBox guest additions
    guest = {
      enable = true;

      # Enable the clipboard and drag-and-drop features
      draganddrop = true;

      # Enable the shared clipboard feature
      clipboard = true;
    };
  };

  # Add the current user to the vboxusers group
  # TODO: move user to a separate file
  users.extraGroups.vboxusers.members = [ "diomeh" ];
}
