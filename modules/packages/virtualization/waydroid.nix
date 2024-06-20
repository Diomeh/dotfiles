{ pkgs, lib, ... }:
{
  # WayDroid requires a Wayland desktop session and cannot be used on X11 directly, but can be run in a nested Wayland session, using e.g. cage.
  # See https://www.hjdskes.nl/projects/cage

  # Enable waydroid
  # For usage instructions see https://nixos.wiki/wiki/WayDroid#Usage
  virtualisation.waydroid.enable = true;

  # On systems with nvidia GPUs you'll need to disable GBM and mesa-drivers
  # File: /var/lib/waydroid/waydroid_base.prop
  # ro.hardware.gralloc=default
  # ro.hardware.egl=swiftshader

  # If clipboard sharing is desired, wl-clipboard is required
  environment.systemPackages = with pkgs; [ wl-clipboard ];

  # Force disable waydroid service so that it is not started at boot
  systemd.services.waydroid-container.wantedBy = lib.mkForce [];
}
