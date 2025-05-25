{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.symbols-only
    nerd-fonts.geist-mono
  ];
}
