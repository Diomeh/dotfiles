{ pkgs, ... }:
let
  username = "diomeh";
in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };
}
