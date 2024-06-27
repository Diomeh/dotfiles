{ pkgs, lib, ... }:
{
  # Enable numlock on display manager
  services.displayManager.sddm.autoNumlock = true;

  # Service to enable numlock on TTYs
  systemd.services.numLockOnTty = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = lib.mkForce (
        pkgs.writeShellScript "numLockOnTty" ''
          for tty in /dev/tty{1..6}; do
              ${pkgs.kbd}/bin/setleds -D +num < "$tty";
          done
        ''
      );
    };
  };
}
