{ ... }:
{
  # Enable fstrim timer to run weekly
  # fstrim is a command line utility that helps to trim the unused blocks on SSD drives
  services.fstrim.enable = true;
}
