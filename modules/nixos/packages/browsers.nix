{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    brave
    microsoft-edge
    google-chrome
    # opera
  ];

  # Install firefox.
  # programs.firefox.enable = true;
}
