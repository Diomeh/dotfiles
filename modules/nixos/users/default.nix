{ pkgs, config, ... }:
let
  user = config.users.default;
in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${user.username}" = {
    isNormalUser = user.isNormalUser;
    description = "${user.description}";
    extraGroups = user.groups;
    shell = user.shell;
    packages = user.pkgs;
  };
}
