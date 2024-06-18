{ pkgs, ... }:
{
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  environment.systemPackages = with pkgs; [
    libsForQt5.kcalc # KDE Calculator
  ];

  # Install KDE Partition Manager
  programs.partition-manager.enable = true;

  # KDE Connect
  programs.kdeconnect.enable = true;
}
