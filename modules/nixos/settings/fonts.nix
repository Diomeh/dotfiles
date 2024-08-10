{ pkgs, ... }:
{
  # Generate fontconfig file
  fonts.fontconfig.enable = true;
  fonts.fontDir.enable = true;

  fonts.fontconfig.defaultFonts.monospace = [ "GeistMono Nerd Font" ];

  # Nerd Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "NerdFontsSymbolsOnly"
        "GeistMono"
      ];
    })
  ];
}
