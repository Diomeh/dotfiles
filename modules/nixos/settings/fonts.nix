{ pkgs, ... }:
{
  # Generate fontconfig file
  fonts.fontconfig.enable = true;
  fonts.fontDir.enable = true;

  fonts.fontconfig.defaultFonts.monospace = [ "GeistMono" ];

  # Nerd Fonts
  fonts.packages = with pkgs; [
    corefonts
    vistafonts
    nerd-fonts.symbols-only
    nerd-fonts.geist-mono
  ];
}
