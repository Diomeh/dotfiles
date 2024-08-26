{ pkgs, ... }:
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
    gnome.zenity # Tool to display dialogs from the commandline and shell scripts
    jetbrains.webstorm # Web development IDE
    jetbrains.rust-rover # Rust IDE
    jetbrains.pycharm-professional # Python IDE
    jetbrains.phpstorm # PHP IDE
    starship # Cross-shell prompt
  ];
}
