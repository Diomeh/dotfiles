{ ... }:
{
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    # Set the DPI to 91. This is device-dependent and may need to be adjusted.
    dpi = 91;

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "altgr-intl";
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # libinput.enable = true;
  };
}
