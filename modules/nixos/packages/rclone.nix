{ config, lib, pkgs, ... }:

with lib;

let
  rclone = config.rclone;
  gdrive = config.rclone.gdrive;
in
{
  environment = mkIf rclone.enable {
    systemPackages = with pkgs; [
      rclone # Rclone is a command line program to manage files on cloud storage
    ];

    # Define the rclone remote configs
    etc."rclone-mnt.conf".text = ''
      [gdrive]
      type = drive
      client_id = ${gdrive.client_id}
      client_secret = ${gdrive.client_secret}
      scope = drive
      root_folder_id = 
      token = ${gdrive.token}
      team_drive = 
    '';
  };

  # Define mount points to cloud storage (ideally, all under /rmt)
  fileSystems."${gdrive.mount}" = mkIf rclone.enable && gdrive.enable {
    device = "gdrive:/";
    fsType = "rclone";
    options = [
      "nodev"
      "nofail"
      "allow_other"
      "args2env"
      "config=/etc/rclone-mnt.conf"
    ];
  };
}
