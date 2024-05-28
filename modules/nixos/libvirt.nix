{ pkgs, ... }:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
      extraConfig = ''uri_default = "qemu:///system"'';
    };
    spiceUSBRedirection.enable = true;
  };

  users.users.diomeh.extraGroups = [ "libvirtd" ];

  environment.systemPackages = with pkgs; [
    spice
    spice-gtk
    spice-protocol
    virt-viewer
    virt-manager
    spice-gtk
    spice-protocol
    virtio-win
    win-spice
    freerdp
    virtiofsd
  ];

  programs.dconf.enable = true;
  programs.virt-manager.enable = true;

  services.spice-vdagentd.enable = true;
}
