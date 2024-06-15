{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # Match configuration name to system hostname for automatic selection
    nixosConfigurations = {
	nixos = nixpkgs.lib.nixosSystem {
		modules = [
			./hosts/vm/configuration.nix
		];
	};
      victus16d00 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/victus16d00/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      vm = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/vm/configuration.nix
        ];
      };
    };
  };
}
