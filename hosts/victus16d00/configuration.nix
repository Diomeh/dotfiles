# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  options,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/nixos/libvirt.nix
    ../../modules/nixos/samba.nix
    ../../modules/nixos/hyprland.nix
  ];

  nix.extraOptions = "experimental-features = nix-command flakes";
  # nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "victus16d00"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # IPV6 fails to connect and is unreachable from https://ipleak.net/, disable it for lack of better solution for now.
  networking.enableIPv6 = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Bogota";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_CO.UTF-8";
    LC_IDENTIFICATION = "es_CO.UTF-8";
    LC_MEASUREMENT = "es_CO.UTF-8";
    LC_MONETARY = "es_CO.UTF-8";
    LC_NAME = "es_CO.UTF-8";
    LC_NUMERIC = "es_CO.UTF-8";
    LC_PAPER = "es_CO.UTF-8";
    LC_TELEPHONE = "es_CO.UTF-8";
    LC_TIME = "es_CO.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = false;
  services.xserver.dpi = 91;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = false;

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "altgr-intl";
    };
  };

  # enables support for Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    input.General.ClassicBondedOnly = false;
  };

  environment.variables = rec {
    VK_DRIVER_FILES = /run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json;
  };

  environment.sessionVariables = {
    # For proton GE
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/diomeh/.steam/root/compatibilitytools.d";
    # For nix helper
    FLAKE = "/home/diomeh/dotfiles";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.diomeh = {
    isNormalUser = true;
    description = "diomeh";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kate
      thunderbird
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "diomeh" = import ./home.nix;
    };
  };

  # Generate fontconfig file
  fonts.fontconfig.enable = true;
  fonts.fontDir.enable = true;

  # Nerd Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    rustup
    gcc
    curl
    vscode-fhs
    brave
    jetbrains-toolbox
    microsoft-edge
    google-chrome
    gitkraken
    wineWowPackages.stable
    winetricks
    lutris
    pciutils
    neofetch
    tlrc
    silver-searcher
    zerotierone
    discord
    vesktop
    gimp-with-plugins
    bc
    libsForQt5.kcalc
    glab
    qbittorrent
    pkgs.appimage-run
    dbeaver-bin
    lshw
    lsof
    bruno
    beekeeper-studio
    libsForQt5.filelight
    vlc
    tree
    steam-run
    devenv
    xdg-utils # Workaround for xdg-open, see: https://github.com/NixOS/nixpkgs/issues/145354
    mangohud # Monitor system resource usage on games. mangohud %command% in Steam launch options
    protonup # Proton GE
    heroic # Heroic Games Launcher
    bottles # Bottles Wine Manager 
    nh # Nix Helper
    nix-output-monitor # Monitor nix builds
    nvd # Nix Visual Debugger
    eza # Easy Archiver
    libreoffice-qt
    hunspell # Spell checker for LibreOffice
    hunspellDicts.en_US # Spell checker english dictionary
    hunspellDicts.es_VE # Spell checker sppanish dictionary
    (import ../../modules/scripts { inherit pkgs; }) # Custom scripts
    # davinci-resolve
    # (import ./fdm.nix)
  ];

  # Enable VirtualBox
  virtualisation.virtualbox = {
    host.enable = true;
    guest = {
      enable = true;
      draganddrop = true;
      clipboard = true;
    };
  };
  users.extraGroups.vboxusers.members = [ "diomeh" ];

  # Enable nix-ld for jetbrains IDE's
  programs.nix-ld = {
    enable = true;
    libraries =
      options.programs.nix-ld.libraries.default
      ++ (with pkgs; [
        # Add missing dynamic libraries for unpackaged
        # programs here, NOT in environment.systemPackages
      ]);
  };

  # Enable direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # Better integration with nix
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Install KDE Partition Manager
  programs.partition-manager.enable = true;

  # Install steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server

    # Optimized micro-compositor for problems with upscaling and resolution
    gamescopeSession.enable = true; # gamescope %command% in Steam launch options
  };

  # Apply optimizations for better performance
  programs.gamemode.enable = true; # gamemoderun %command% in Steam launch options

  # KDE Connect
  programs.kdeconnect.enable = true;

  # Intel support for Davinci Resolve
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ intel-compute-runtime ];
  };

  networking.firewall = {
    enable = false;

    allowedTCPPorts = [
      80
      443
    ];
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];

    allowedUDPPorts = [
      67 # DHCP for dnsmasq
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];

    trustedInterfaces = [
      "wlo1" # Wifi interface
    ];
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

  virtualisation.docker.enable = true;

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.flatpak.enable = true;

  # Enable fstrim timer to run weekly
  services.fstrim.enable = true;

  # Hotspot related DNS resolver issue, systemd-resolved may be a working alternative
  # services.dnsmasq = {
  #   enable = true;
  #   settings = {
  #     bind-interfaces = true;
  #     server = [
  #       "1.1.1.1"
  #       "1.0.0.1"
  #     ];
  #   };
  # };

  # Needed for Mullvad VPN (see: https://discourse.nixos.org/t/connected-to-mullvadvpn-but-no-internet-connection/35803/8?u=lion)
  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [
      "https://discourse.nixos.org/t/connected-to-mullvadvpn-but-no-internet-connection/35803/8?u=lion"
      "1.1.1.1"
      "1.0.0.1"
    ];
    dnsovertls = "true";
  };

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
