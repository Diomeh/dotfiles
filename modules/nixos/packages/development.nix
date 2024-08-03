{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vscode-fhs # Visual Studio Code with FHS support
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
    shfmt # Shell script formatter
    shellcheck # Shell script linter
    shunit2 # Shell script unit testing framework
    blender # 3D creation suite
    jetbrains.webstorm # Web development IDE
    jetbrains.rust-rover # Rust IDE
    jetbrains.pycharm-professional # Python IDE
    jetbrains.phpstorm # PHP IDE
  ];
}
