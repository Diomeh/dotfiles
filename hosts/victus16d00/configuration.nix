# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    # Import drivers
    ../../modules/drivers/opengl.nix
    ../../modules/drivers/nvidia.nix
    # ../../modules/drivers/power-management.nix

    # Import users
    ../../modules/users/diomeh.nix

    # Import settings
    ../../modules/settings/bluetooth.nix
    ../../modules/settings/cups.nix
    ../../modules/settings/firewall.nix
    ../../modules/settings/fonts.nix
    ../../modules/settings/fstrim.nix
    ../../modules/settings/home-manager.nix
    ../../modules/settings/locales.nix
    ../../modules/settings/network.nix
    ../../modules/settings/sound.nix
    ../../modules/settings/x11.nix

    # Import DE
    ../../modules/settings/desktops/kde5.nix
    # ../../modules/settings/desktops/hyprland.nix

    # Import packages
    ../../modules/packages/browsers.nix
    ../../modules/packages/development.nix
    ../../modules/packages/direnv.nix
    ../../modules/packages/docker.nix
    ../../modules/packages/gaming.nix
    ../../modules/packages/libvirt.nix
    ../../modules/packages/misc.nix
    ../../modules/packages/mullvad.nix
    ../../modules/packages/nix-helper.nix
    ../../modules/packages/nix-ld.nix
    ../../modules/packages/office.nix
    ../../modules/packages/package-managers.nix
    ../../modules/packages/samba.nix
    ../../modules/packages/steam.nix
    ../../modules/packages/sys-utils.nix
    ../../modules/packages/virtualbox.nix
    ../../modules/packages/wine.nix
    ../../modules/packages/zsh.nix

    # Import specialisations
    ../../modules/specialisations/on-the-go.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable nix commands and flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Define your hostname.
  networking.hostName = "victus16d00"; 

  environment.variables = {
    # TODO: find out what does this variable do
    VK_DRIVER_FILES = /run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
