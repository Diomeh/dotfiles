{ config, pkgs, ... }:
let
  username = "diomeh";
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  # wayland.windowManager.hyprland.enable = true;
  # wayland.windowManager.hyprland.settings = {
  #   "$mod" = "SUPER";
  #   bind =
  #     [
  #       "$mod, F, exec, firefox"
  #       ", Print, exec, grimblast copy area"
  #     ]
  #     ++ (
  #       # workspaces
  #       # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
  #       builtins.concatLists (builtins.genList (
  #           x: let
  #             ws = let
  #               c = (x + 1) / 10;
  #             in
  #               builtins.toString (x + 1 - (c * 10));
  #           in [
  #             "$mod, ${ws}, workspace, ${toString (x + 1)}"
  #             "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
  #           ]
  #         )
  #         10)
  #     );
  # };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    eza # Replacemnt for ls
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Kitty terminal emulator
  # See: 
  # - https://github.com/nix-community/home-manager/blob/master/modules/programs/kitty.nix
  # - https://sw.kovidgoyal.net/kitty/conf.html
  programs.kitty = {
    enable = true;
    theme = "Space Gray Eighties";
    shellIntegration.enableZshIntegration = true;
    font = {
      name = "Fira Code";
      size = 12;
      package = pkgs.fira-code;
    };
    settings = {
      disable_ligatures = "always";
      cursor_shape = "beam";
      scrollback_pager_history_size = 1024;
      scrollback_fill_enlarged_window = "yes";
      mouse_hide_wait = 0;
      show_hyperlink_targets = "yes";
      underline_hyperlinks = "always";
      paste_actions = "quote-urls-at-prompt,confirm,replace-dangerous-control-codes,replace-newline,filter";
      strip_trailing_spaces = "always";
      confirm_os_window_close = 0;
      notify_on_cmd_finish = "unfocused";
      wayland_enable_ime = "no";
    };
    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
      "ctrl+shift+enter" = "new_window_with_cwd";
      "ctrl+shift+n" = "new_os_window_with_cwd";
    };
    environment = { };
    extraConfig = ''
      # Add your custom kitty configuration here
    '';
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      expireDuplicatesFirst = true;
      extended = true; # Save timestamp into the history file.
      ignoreDups = true; # Do not enter command lines into the history list if they are duplicates of the previous event.
      save = 10000; # Number of history lines to save in the history file.
      share = true; # Share history between zsh sessions.
      size = 10000; # Number of history lines to save in the history list.
    };

    plugins = [];

    shellAliases = {
      ls = "${pkgs.eza}/bin/eza --git --icons"; # Display icons and git status
      l = "ls -lahbX"; # Long format, all files, show header, binary size prefix, dereference symlinks
      ll = "ls -l"; # Long format
      la = "ls -a"; # All files
      lt = "ls --tree"; # Tree format
      ldir = "l -D"; # Directories only
      lfil = "l -f"; # Files only
    };

    # Extra commands that should be added to {file}.zshrc before compinit.
    initExtraBeforeCompInit = ''
      # Add your custom zsh configuration here
    '';

    # Extra commands that should be added to {file}.zshrc.
    initExtra = ''
      # Disable user@system in shell prompt
      prompt_context(){}

      # ??? No idea why this is here
      export XDG_DATA_HOME="$HOME/.local/share"
    '';

    oh-my-zsh = {
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
      extraConfig = ''
        # Add your custom oh-my-zsh configuration here
      '';
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/${username}/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
