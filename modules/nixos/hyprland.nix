{ pkgs, lib, inputs, ... }:

let
  use_nvidia_gpu = config.boot.kernelPackages == pkgs.linuxPackages.nvidia_x11;
in {
  # Enable hyprland cachix for home-manager module
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  environment.sessionVariables = lib.mkIf use_nvidia_gpu {
    # WAYLAND_DISPLAY = ":1";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "hyprland";

    # Prevent invisible cursor
    WLR_NO_HARDWARE_CURSORS = "1";

    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
    libnotify
    dunst # Notification daemon
    swww # Sway wallpaper
    kitty # Terminal emulator
    rofi-wayland # Application launcher
    networkmanagerapplet # Network manager applet
    grim # Screenshot tool
    slurp # Select tool
    wl-clipboard # Clipboard manager
  ];

  # Disable KDE forcefully
  services.xserver.desktopManager.plasma5.enable = lib.mkForce false;

  # Enable desktop portals
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
}
