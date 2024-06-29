{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gimp-with-plugins # GNU Image Manipulation Program
    qbittorrent # A free and open-source BitTorrent client
    vlc # A free and open-source media player
    thunderbird # Thunderbird email client

    # Custom packages
    (import ../../../modules/nixos/packages/custom { inherit pkgs; })

    # Binary dependencies for custom packages
    wl-clipboard # copy, paste (wayland)
    xclip # copy, paste (X11)
    p7zip # xtract
    unzip # xtract
    unrar # xtract
  ];
}
