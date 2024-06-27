{ pkgs, ... }:
{
  # For Plasma 6 under nvidia is ideal to switch to beta proprietary drivers for better performance and stability.
  # This will also deal with stuttering and screen tearing issues.

  # Use the SDDM display manager.
  services.displayManager.sddm.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;

  # Enable Qt 5 integration (theming, etc). Disable for a pure Qt 6 system.
  services.desktopManager.plasma6.enableQt5Integration = true;

  environment.systemPackages = with pkgs; [
    libsForQt5.kcalc # KDE Calculator
  ];

  # Install KDE Partition Manager
  programs.partition-manager.enable = true;

  # KDE Connect
  programs.kdeconnect.enable = true;
}
