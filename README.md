
# NixOS Configuration Repository

This repository contains the configuration files and modules for setting up and managing a NixOS system.

## Getting Started

### Prerequisites

Ensure you have Nix installed on your system. Follow the [Nix installation guide](https://nixos.wiki/wiki/Nix_Installation_Guide) for instructions.

### Using the Configuration

#### First Time Setup

Clone the repository

```bash
git clone https://github.com/Diomeh/dotfiles.git
cd dotfiles
```

Add NixOS and home-manager channels *(list of available channels [here](https://channels.nixos.org))*

> [!NOTE]
> It is best to keep NixOS and home-manager channels in sync,
> i.e. if on `nixos-24.11` use `nixos-24.11` and `release-24.11.tar.gz`
> for both `nixos` and `home-manager` respectively.

We also add `nixos-unstable` channel to allow for installing packages from unstable release

```bash
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
sudo nix-channel --add https://nixos.org/channels/nixos-24.11 nixos
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
```

Update the channels:

```bash
sudo nix-channel --update
```

##### Setup your user

Copy `hosts/nixos/options.nix.example` to `hosts/nixos/options.nix`, then update the user definition

```nix
  mkUserOption = {
    isNormalUser = true; # Is this a human user?
    username = "user"; ### change 'user' for your desired username 
    description = "user";
    groups = ["wheel" "networkmanager"];
    shell = pkgs.zsh;
    home = "/home/user";
    pkgs = with pkgs; [ ];
  };
```

##### Setup hostname *(optional)*

If you wish to use another hostname instead of the default `nixos`, change

1. `flake.nix`: Under `nixosConfigurations` copy or edit the configuration with your desired hostname
2. In `hosts/nixos/configuration.nix` update entry `networking.hostName`
3. In `modules/nixos/settings/home-manager.nix` update variable `hostname`
4. Update hostname directory under `hosts/`

##### Setup hardware config

As hardware config will be different for every host, use the one generated during distro installation


> [!NOTE]
> If you changed hostname, use the one you defined instead of `nixos`

```bash
sudo copy -fv /etc/nixos/hardware-configuration.nix ./hosts/nixos/
```

##### Update flake *(optional)*

```nix
nix --extra-experimental-features nix-command --extra-experimental-features flakes flake lock
nix --extra-experimental-features nix-command --extra-experimental-features flakes flake update
```

##### Bootloader

> [!IMPORTANT]
> Bootloader configuration will be different for different NixOS setups, 
> it is recommened to copy definitions from `/etc/nixos/configuration.nix`
> to `./hosts/nixos/configuration.nix`

***

#### Apply config

Apply the configuration (if changed replace hostname of the system, `nixos` by default):

```bash
sudo nixos-rebuild switch --flake .#nixos
```

If on `zsh` shell, apply configuration like so:

```bash
sudo nixos-rebuild switch --flake ".#nixos"
```

#### Regarding `nix-helper`

`nh` requires that the flake path be explicitly specified or set in an environment variable, which is defined in
[./modules/settings/nix-helper.nix](./modules/settings/nix-helper.nix), set it accordingly to the repo path.
```nix
{
  environment.sessionVariables = {
    FLAKE = "/home/${username}/dotfiles";
  };
}
```

> [!IMPORTANT]
> Configuration names defined in `flake.nix` must match the system name in `networking.hostName` for correct `nh` operation.

#### Updating the Configuration

After making changes to the configuration, apply the changes by running:

```bash
nh os switch
```

This will use the `nix-helper` utility to rebuild both system and home-manager configurations by 
reading the `flake.nix` file located in `FLAKE` environment variable and inferring the configuration name from the `hostName` field in `configuration.nix`.

### Customizing Your Configuration

The project is organized into `hosts` and `modules`.
- `hosts` contains the configuration for individual hosts, here you can find `configuration.nix`, `hardware-configuration.nix` and `home.nix` if using home-manager.
Each host directory should be named the same as `networking.hostName` in `configuration.nix`, this is to ensure the correct configuration is applied.
- `modules` contains a collection of modules grouped by their purpose. each directory may contain subdirectories for further organization.
    - `drivers`: hardware drivers such as `nvidia`, `intel`, `amd`, etc.
    - `packages`: packages to be installed on the system
    - `settings`: system settings such as `locale`, `time`, etc.
    - `specialisations`: NixOS specialisations.
    - `users`: user settings.

At the root of the project you'll also find a `flake.nix` file which is used to build the system configuration.
The flake defines all the systems to be built and the inputs required to build them.

## Additional information

### Errors

If when building you get the error `error: getting status of '/nix/store/.../*.nix': No such file or directory`, stage all changes on git and re-run the command.
It is not necessary to commit the changes.

```bash
git add .
nh os switch
```

### Systemd Services

Some systemd services have been configured so as to not start on boot, to start them manually run:

```bash
sudo systemctl start [service-name]
```

The services are:
- [./modules/packages/virtualization/docker.nix](./modules/packages/virtualization/docker.nix)
    - `docker`
- [./modules/packages/virtualization/libvirt.nix](./modules/packages/virtualization/libvirt.nix)
    - `libvirtd`
    - `libvirt-guests`
    - `spice-vdagentd`
- [./modules/packages/virtualization/waydroid.nix](./modules/packages/virtualization/waydroid.nix)
    - `waydroid-container`

This has been achieved by setting `systemd.services.<service-name>.wantedBy = lib.mkForce [];` in the configuration,
if you wish to start the service on boot, simply comment out the line.

See the following resources for more information:
- [NixOS Discourse](https://discourse.nixos.org/t/disable-a-systemd-service-while-having-it-in-nixoss-conf/12732/4)
- [NixOS Options](https://search.nixos.org/options?channel=24.05&show=systemd.services.%3Cname%3E.wantedBy&from=0&size=50&sort=relevance&type=packages&query=systemd.services)

## Contributing

Contributions are welcome! Please open an issue or submit a pull request with your changes.

## License

This repository is licensed under the MIT License. See the [LICENSE](./LICENSE) file for more information.
