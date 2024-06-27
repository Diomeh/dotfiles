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
      # ctrl + backspace to delete word
      bindkey '^H' backward-kill-word

      # ctrl + delete to delete word
      bindkey '^[[3;5~' kill-word

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
}
