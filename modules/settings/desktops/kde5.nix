{ pkgs, ... }:
{
  # Use the SDDM display manager.
  services.displayManager.sddm.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable HiDPI scaling in Qt.
  services.xserver.desktopManager.plasma5.useQtScaling = true;

  environment.systemPackages = with pkgs; [
    libsForQt5.kcalc # KDE Calculator
  ];

  # Install KDE Partition Manager
  programs.partition-manager.enable = true;

  # KDE Connect
  programs.kdeconnect.enable = true;
}
