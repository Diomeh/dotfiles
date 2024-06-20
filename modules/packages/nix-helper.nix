{ pkgs, ... }:
let
  username = "diomeh";
in
{
  environment.sessionVariables = {
    # For nix helper
    # TODO: read this from a separate file
    FLAKE = "/home/${username}/dotfiles";
  };

  environment.systemPackages = with pkgs; [
    nh # Nix Helper
    nix-output-monitor # Monitor nix builds
    nvd # Nix Visual Debugger
  ];
}
