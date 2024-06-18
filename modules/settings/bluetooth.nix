{ ... }:
{
  # Enables support for Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    input.General.ClassicBondedOnly = false;
  };

  # Enable the Blueman Bluetooth manager
  # TODO: check if necessary on KDE
  # services.blueman.enable = true;
}
