{ ... }:
{
  fileSystems."/mnt/drive" =
    { device = "/dev/disk/by-uuid/e47201c1-b95a-442b-a1e1-36caeba0babc";
      fsType = "ext4";
    };
}
