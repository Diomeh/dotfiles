{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libreoffice-qt # LibreOffice with Qt interface
    hunspell # Spell checker for LibreOffice
    hunspellDicts.en_US # Spell checker english dictionary
    hunspellDicts.es_VE # Spell checker sppanish dictionary
  ];
}
