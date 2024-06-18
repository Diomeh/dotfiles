{ config, pkgs, ... }:
{
  # Add support for AppImage files
  environment.systemPackages = with pkgs; [ appimage-run ];

  # Enable the Flatpak package manager
  services.flatpak.enable = true;

  # Nix related settings
  # TODO: read these settings from a separate file, same as ./modules/drives/nvidia.nix PRIME bus ID values

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Add unstable packages as an overlay
  nixpkgs.config.packageOverrides = pkgs: {
    unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
  };

  # Allow insecure packages
  nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1w" ];
}
