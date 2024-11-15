{ pkgs, options, ... }:
{
  # Enable nix-ld
  # This module adds missing dynamic libraries for unpackaged programs
  programs.nix-ld = {
    enable = true;
    libraries =
      options.programs.nix-ld.libraries.default
      ++ (with pkgs; [
        # Add missing dynamic libraries for unpackaged
        # programs here, NOT in environment.systemPackages
      ])
      # Add steam-run DLL's
      ++ (pkgs.steam-run.fhsenv.args.multiPkgs pkgs);
  };
}
