{ pkgs, ... }:
{
  # Generate fontconfig file
  fonts.fontconfig.enable = true;
  fonts.fontDir.enable = true;

  # Nerd Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];
}
