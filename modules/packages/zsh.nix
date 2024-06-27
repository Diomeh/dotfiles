{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    zsh-autoenv.enable = true; # No option found in home-manager
  };
}
