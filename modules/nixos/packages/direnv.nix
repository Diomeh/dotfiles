{ ... }:
{
  # Enable direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # Better integration with nix
  };
}
