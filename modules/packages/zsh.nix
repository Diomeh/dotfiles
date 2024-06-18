{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Replacemnt for ls
    eza
  ];

  programs.zsh = {
    # Enable zsh
    enable = true;

    # Enable zsh plugins
    enableCompletion = true;
    autosuggestions.enable = true;
    zsh-autoenv.enable = true;
    syntaxHighlighting.enable = true;

    # Enable Oh My Zsh
    ohMyZsh = {
      enable = true;
      theme = "agnoster";

      # Enable plugins
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

    # Set zsh aliases
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
}
