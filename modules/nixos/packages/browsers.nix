{ pkgs, config, ... }:
let
  nixos-2411 = import <nixos-24.11> {
    # reuse the current configuration
    config = config.nixpkgs.config;
  };
in
{
  environment.systemPackages = with pkgs; [
    brave
    nixos-2411.microsoft-edge
    google-chrome
    # opera
  ];

  # Install firefox.
  # programs.firefox.enable = true;
}
