{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vscode-fhs # Visual Studio Code with FHS support
    jetbrains-toolbox # JetBrains Toolbox
    gitkraken # GitKraken Git GUI
    rustup # Rust programming language
    bacon # Background rust code checker
    glab # GitLab CLI
    bruno # API testing tool
    beekeeper-studio # SQL GUI
    dbeaver-bin # SQL GUI
    kate # Kate text editor
    sublime4 # Sublime Text
    zed-editor # Zed text editor
    obsidian # Obsidian note-taking app
  ];
}
