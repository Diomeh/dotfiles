{ pkgs, ... }:
{
  # ext4 partition
  fileSystems."/mnt/drive" =
    { device = "/dev/disk/by-uuid/e47201c1-b95a-442b-a1e1-36caeba0babc";
      fsType = "ext4";
    };

  # ntfs partition
  environment.systemPackages = [
    pkgs.ntfs3g
  ];

  fileSystems."/mnt/ntfs" =
    { device = "/dev/disk/by-uuid/D6744E28744E0C25";
      fsType = "ntfs-3g"; 
      options = [ "rw" "uid=1000"];
    };
}
