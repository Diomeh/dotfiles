# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    # Import drivers
    ../../modules/nixos/drivers/opengl.nix
    ../../modules/nixos/drivers/nvidia.nix
    ../../modules/nixos/drivers/power-management.nix

    # Import users
    ../../modules/nixos/users

    # Import settings
    ../../modules/nixos/settings/bluetooth.nix
    ../../modules/nixos/settings/cups.nix
    ../../modules/nixos/settings/firewall.nix
    ../../modules/nixos/settings/fonts.nix
    ../../modules/nixos/settings/fstrim.nix
    ../../modules/nixos/settings/home-manager.nix
    ../../modules/nixos/settings/locales.nix
    ../../modules/nixos/settings/network.nix
    ../../modules/nixos/settings/numlock.nix
    ../../modules/nixos/settings/sound.nix
    ../../modules/nixos/settings/x11.nix

    # Import DE
    # ../../modules/nixos/settings/desktops/kde5.nix
    ../../modules/nixos/settings/desktops/kde6.nix
    # ../../modules/nixos/settings/desktops/hyprland.nix

    # Import packages
    ../../modules/nixos/packages/browsers.nix
    ../../modules/nixos/packages/development.nix
    ../../modules/nixos/packages/direnv.nix
    ../../modules/nixos/packages/misc.nix
    ../../modules/nixos/packages/mullvad.nix
    ../../modules/nixos/packages/nix-helper.nix
    ../../modules/nixos/packages/nix-ld.nix
    ../../modules/nixos/packages/office.nix
    ../../modules/nixos/packages/openssl.nix
    ../../modules/nixos/packages/package-managers.nix
    ../../modules/nixos/packages/samba.nix
    ../../modules/nixos/packages/sys-utils.nix
    ../../modules/nixos/packages/zsh.nix

    # Import custom packages
    # Infinite recursion ?????????????
    # Importing in modules/nixos/packages/misc.nix causes no problems
    # (import ../../modules/nixos/packages/custom { inherit pkgs; }) 

    # Gaming related stuff
    ../../modules/nixos/packages/gaming/launchers.nix
    ../../modules/nixos/packages/gaming/steam.nix
    ../../modules/nixos/packages/gaming/wine.nix

    # Virtualization
    ../../modules/nixos/packages/virtualization/docker.nix
    ../../modules/nixos/packages/virtualization/libvirt.nix
    ../../modules/nixos/packages/virtualization/virtualbox.nix
    ../../modules/nixos/packages/virtualization/waydroid.nix

    # Import specialisations
    ../../modules/nixos/specialisations/on-the-go.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable nix commands and flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Define your hostname.
  networking.hostName = "victus16d00";

  # Needed for home-manager ZSH completion
  environment.pathsToLink = [ "/share/zsh" ];

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
