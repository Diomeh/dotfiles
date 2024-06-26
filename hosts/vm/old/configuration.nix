{ config, pkgs, inputs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/virtualbox-demo.nix>
    ./hardware-configuration.nix
		../../modules/nixos/hyprland.nix
  ];

  # Enabled in hyprland.nix
  # hardware.nvidia.modesetting.enable = false;

  # Don't require password for sudo
  security.sudo.wheelNeedsPassword = false;

  # Enable unfree packages
  nixpkgs.config.allowUnfree = true; 

	# Enable experimental features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.sessionVariables = {
    # For nix helper
    FLAKE = "/home/demo/dotfiles";
  };

  # Let demo build as a trusted user.
  # nix.settings.trusted-users = [ "demo" ];

  # Mount a VirtualBox shared folder.
  # This is configurable in the VirtualBox menu at
  # Machine / Settings / Shared Folders.
  # fileSystems."/mnt" = {
  #   fsType = "vboxsf";
  #   device = "nameofdevicetomount";
  #   options = [ "rw" ];
  # };

  # By default, the NixOS VirtualBox demo image includes SDDM and Plasma.
  # If you prefer another desktop manager or display manager, you may want
  # to disable the default.
  # services.xserver.desktopManager.plasma5.enable = lib.mkForce false;
  # services.displayManager.sddm.enable = lib.mkForce false;

  # Enable GDM/GNOME by uncommenting above two lines and two lines below.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search, run:
  # \$ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    git
		vscode-fhs
    eza
    nh # Nix Helper
    kate
  ];

  users.users.demo = {
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    zsh-autoenv.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git"
        "npm"
        "history"
        "node"
        "rust"
        "deno"
        "docker"
        "web-search"
        "direnv"
      ];
    };
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza --git --icons"; # Display icons and git status
      l = "ls -lahbX"; # Long format, all files, show header, binary size prefix, dereference symlinks
      ll = "ls -l"; # Long format
      la = "ls -a"; # All files
      lt = "ls --tree"; # Tree format
      ldir = "l -D"; # Directories only
      lfil = "l -f"; # Files only
    };
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
}
