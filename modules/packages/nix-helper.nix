{ pkgs, ... }:
{
  environment.sessionVariables = {
    # For nix helper
    # TODO: read this from a separate file
    FLAKE = "/home/diomeh/dotfiles";
  };

  environment.systemPackages = with pkgs; [
    nh # Nix Helper
    nix-output-monitor # Monitor nix builds
    nvd # Nix Visual Debugger
  ];
}
