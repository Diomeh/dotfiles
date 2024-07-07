{ pkgs, ... }:
{
  home.packages = with pkgs; [
    eza # Replacemnt for ls
  ];

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
      # FIXME: kitty terminal doesn't render icons
      ls = "${pkgs.eza}/bin/eza --git"; # Display git status 
      # ls = "${pkgs.eza}/bin/eza --git --icons"; # Display icons and git status

      l = "ls -lahbX"; # [l]ong format, [a]ll files, s[h]ow header, [b]inary size prefix, dereference symlinks
      ll = "ls -l"; # [l]ong format
      la = "ls -a"; # [a]ll files
      lt = "ls --tree"; # Tree format
      ldir = "l -D"; # [D]irectories only
      lfil = "l -f"; # [f]iles only
    };

    # Extra commands that should be added to {file}.zshrc before compinit.
    initExtraBeforeCompInit = ''
      # Add your custom before compinit zsh configuration here 
    '';

    # Extra commands that should be added to {file}.zshrc.
    initExtra = ''
      # ctrl + backspace to delete word to the left of cursor
      bindkey '^H' backward-kill-word

      # ctrl + delete to delete word to the right of cursor
      bindkey '^[[3;5~' kill-word

      # Disable user@system in shell prompt (needed for om-my-zsh agnoster theme)
      prompt_context(){}

      # ??? No idea why this is here
      export XDG_DATA_HOME="$HOME/.local/share"

      # JetBrains IDEs
      PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

      # Force export PKG_CONFIG_PATH so that rust IDEs can find openssl
      # Theoretically this should work with environment.sessionVariables but it doesn't
      export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig"
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

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;
}
