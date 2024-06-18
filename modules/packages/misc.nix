{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gimp-with-plugins # GNU Image Manipulation Program
    qbittorrent # A free and open-source BitTorrent client
    vlc # A free and open-source media player
    thunderbird # Thunderbird email client
    (import ../../modules/packages/custom { inherit pkgs; }) # Custom packages
  ];
}
