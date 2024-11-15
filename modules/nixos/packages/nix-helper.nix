{ pkgs, config, ... }:
{
  environment.sessionVariables = {
    # For nix helper
    FLAKE = "/home/${config.users.default.username}/dotfiles";
  };

  environment.systemPackages = with pkgs; [
    nh # Nix Helper
    nix-output-monitor # Monitor nix builds
    nvd # Nix Visual Debugger
  ];
}
