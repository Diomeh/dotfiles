{ lib, ... }:
{
  # On the go specialization
  # This specialization is for laptops and other mobile devices
  # It is optimized for battery life and portability
  specialisation = {
    # TODO: Check whether we're running an Nvidia GPU before applying this configuration
    on-the-go.configuration = {
      # Tag the specialisation
      system.nixos.tags = [ "on-the-go" ];

      # GPU sleeps by default and is only used when explicitly requested
      # GPU intensive applications must be run through nvidia-offload
      hardware.nvidia = {
        # Disable sync
        prime.sync.enable = lib.mkForce false;

        # Enable offload
        prime.offload.enable = lib.mkForce true;
        prime.offload.enableOffloadCmd = lib.mkForce true;
      };

      # Make specialisation name accessible inside NixOS environment
      environment.etc."specialisation".text = "on-the-go";
    };
  };
}
