{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    # driSupport = true;
    # driSupport32Bit = true;
    extraPackages = with pkgs; [ intel-compute-runtime ];
  };
}
