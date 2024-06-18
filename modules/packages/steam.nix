{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mangohud # Monitor system resource usage on games. mangohud %command% in Steam launch options
  ];

  # Install steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server

    # Optimized micro-compositor for problems with upscaling and resolution
    gamescopeSession.enable = true; # gamescope %command% in Steam launch options
  };

  # Apply optimizations for better performance
  programs.gamemode.enable = true; # gamemoderun %command% in Steam launch options
}
