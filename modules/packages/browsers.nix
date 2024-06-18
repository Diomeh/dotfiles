{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    brave
    microsoft-edge
    google-chrome
  ];

  # Install firefox.
  programs.firefox.enable = true;
}
