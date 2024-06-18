{ pkgs, ... }:
{
  environment.sessionVariables = {
    # For proton GE
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/diomeh/.steam/root/compatibilitytools.d";
  };

  environment.systemPackages = with pkgs; [
    wineWowPackages.stable # wine 64-bit
    winetricks
    protonup # Proton GE
  ];
}
