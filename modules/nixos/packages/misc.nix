{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # gimp-with-plugins # GNU Image Manipulation Program
    # qbittorrent # A free and open-source BitTorrent client
    # vlc # A free and open-source media player
    thunderbird # Thunderbird email client
    # kdePackages.kio-gdrive # KIO Slave to access Google Drive
    # kdePackages.kaccounts-providers # KDE accounts providers
    # kdePackages.kaccounts-integration # KDE accounts integration
    #TODO: ente fails with "[1]    61490 segmentation fault"
    # ente-auth # 2fa token manager
    protonvpn-gui # Proton VPN GTK app for Linux
    tree # Command to produce a depth indented directory listing

    (import ../../../modules/nixos/packages/dsu { inherit pkgs; })

    # Runtime dependencies for dsu
    wl-clipboard # copy, paste (wayland)
    xclip # copy, paste (X11)
    p7zip # xtract
    unzip # xtract
    unrar # xtract
    obs-studio # Free and open source software for video recording and live streaming
    mailspring # Beautiful, fast and maintained fork of Nylas Mail by one of the original authors
  ];
}
