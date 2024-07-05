{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gimp-with-plugins # GNU Image Manipulation Program
    qbittorrent # A free and open-source BitTorrent client
    vlc # A free and open-source media player
    thunderbird # Thunderbird email client

    (import ../../../modules/nixos/packages/dsu { inherit pkgs; })

    # Binary dependencies for dsu
    wl-clipboard # copy, paste (wayland)
    xclip # copy, paste (X11)
    p7zip # xtract
    unzip # xtract
    unrar # xtract
  ];
}
