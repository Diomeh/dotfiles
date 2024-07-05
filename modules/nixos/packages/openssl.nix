{ pkgs, ... }:
{
  # This is all needed by any rust projects that use openssl
  # See: https://nixos.wiki/wiki/Rust#Building_Rust_crates_that_require_external_system_libraries

  environment.sessionVariables = {
    # For proton GE
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

  environment.systemPackages = with pkgs; [
    pkg-config
    openssl
  ];
}
