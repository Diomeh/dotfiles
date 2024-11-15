{ inputs, pkgs, config, ... }:
let
  hostname = "victus16d00";
in
{
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  # home-manager configuration
  home-manager = {
    extraSpecialArgs = { inherit inputs; };

    # Backup dotfiles files when doing rebuilds in case of conflicts
    # Useful when migrating a package from nixpkgs to home-manager
    backupFileExtension = "backup"; 

    users = {
      "${config.users.default.username}" = import ../../../hosts/${hostname}/home.nix;
    };
  };
}
