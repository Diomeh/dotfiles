{ pkgs, config, ... }:
let
  unstable = import <nixos-unstable> {
    # reuse the current configuration
    config = config.nixpkgs.config;
  };
in
{
  environment.systemPackages = with pkgs; [
    vscode-fhs # Visual Studio Code with FHS support
    gitkraken # GitKraken Git GUI
    glab # GitLab CLI
    bruno # API testing tool
    beekeeper-studio # SQL GUI
    dbeaver-bin # SQL GUI
    kate # Kate text editor
    sublime4 # Sublime Text
    zenity # Tool to display dialogs from the commandline and shell scripts
    unstable.jetbrains.webstorm # Web development IDE
    unstable.jetbrains.rust-rover # Rust IDE
    unstable.jetbrains.pycharm-professional # Python IDE
    unstable.jetbrains.phpstorm # PHP IDE
    starship # Cross-shell prompt
    nurl # Nixos URL fetcher generator
    nix-init # Nixos package generator
    slack # Desktop client for Slack
  ];
}
