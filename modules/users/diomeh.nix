{ pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.diomeh = {
    isNormalUser = true;
    description = "diomeh";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };
}
