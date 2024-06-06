
# NixOS Configuration Repository

This repository contains the configuration files and modules for setting up and managing a NixOS system.

## Repository Structure

```
├── configuration.nix
├── flake.lock
├── flake.nix
├── hardware-configuration.nix
├── modules: Directory containing custom NixOS modules and scripts.
│   ├── nixos: Specific NixOS module configurations.
│   │   ├── ...
│   └── scripts: Utility scripts.
│       ├── default.nix: Nix expression for building the scripts.
│       └── src: Source directory for the utility scripts.
│           ├── ...
├── README.md
```

## Getting Started

### Prerequisites

Ensure you have Nix installed on your system. Follow the [Nix installation guide](https://nixos.wiki/wiki/Nix_Installation_Guide) for instructions.

### Using the Configuration

Clone the repository:

```bash
git clone https://github.com/Diomeh/dotfiles.git
cd dotfiles
```

Apply the configuration:

```bash
sudo nixos-rebuild switch --flake .#
```

If on `zsh` shell, apply configuration like so:

```bash
sudo nixos-rebuild switch --flake ".#default"
```

### Customizing Your Configuration

Modify `configuration.nix` to change system settings and add or remove packages.

Update or add new modules in the `modules/nixos/` directory for additional services and configurations.

Edit or create new scripts in the `modules/scripts/src/` directory for custom utilities.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request with your changes.

## License

This repository is licensed under the MIT License. See the [LICENSE](./LICENSE.md) file for more information.
