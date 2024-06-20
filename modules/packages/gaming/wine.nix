{ pkgs, ... }:
{
  environment.sessionVariables = {
    # For proton GE
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/diomeh/.steam/root/compatibilitytools.d";
  };

  environment.variables = {
    # Prevent error `Nvidia DRM kernel driver ‘nvidia-drm’ in use. NVK requires nouveau` when running wine
    VK_DRIVER_FILES = /run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json;
  };

  environment.systemPackages = with pkgs; [
    wineWowPackages.stable # wine 64-bit
    winetricks
    protonup # Proton GE
  ];
}
