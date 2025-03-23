# NixOS Configuration Repository

**Table of Contents**

- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [First Time Setup](#first-time-setup)
    - [Clone the repository](#clone-the-repository)
    - [Add NixOS and home-manager channels](#add-nixos-and-home-manager-channels-list-of-available-channels-herehttpschannelsnixosorg)
    - [Update the channels](#update-the-channels)
    - [List current channels](#list-current-channels)
    - [Setup your user](#setup-your-user)
    - [Setup hostname *(optional)*](#setup-hostname-optional)
    - [Setup hardware config](#setup-hardware-config)
    - [Update flake *(optional)*](#update-flake-optional)
    - [Regarding the bootloader](#regarding-the-bootloader)
  - [Using the configuration](#using-the-configuration)
    - [With `nix` commands](#with-nix-commands)
      - [Applying changes](#applying-changes)
      - [Updating the system](#updating-the-system)
      - [Cleaning out the system](#cleaning-out-the-system)
    - [Using `nix-helper`](#using-nix-helper)
      - [Updating the system](#updating-the-system-1)
      - [Cleaning out the system](#cleaning-out-the-system-1)
  - [Customizing Your configuration](#customizing-your-configuration)
- [Additional information](#additional-information)
  - [Errors](#errors)
  - [Systemd Services](#systemd-services)
- [Home Manager](#home-manager)
- [Specializations](#specializations)
- [Contributing](#contributing)
- [License](#license)
  
## Getting Started

### Prerequisites

Ensure you have Nix installed on your system. Follow the [Nix installation guide](https://nixos.wiki/wiki/Nix_Installation_Guide) for instructions.

### First Time Setup

#### **Clone the repository**

```bash
git clone https://github.com/Diomeh/dotfiles.git
cd dotfiles
```

#### Add NixOS and home-manager channels *(list of available channels [here](https://channels.nixos.org))*

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

#### Update the channels

```bash
sudo nix-channel --update
```

#### List current channels

Ensure all channels have been properly set up.

```bash
sudo nix-channel --list
```

You should see all available channels like so
```bash
home-manager https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz
nixos https://nixos.org/channels/nixos-24.11
nixos-unstable https://nixos.org/channels/nixos-unstable
```

#### Setup your user

> [!NOTE]
> `options.nix` defines user-specific settings and should not be commited to source control.

Copy `hosts/nixos/options.nix.example` to `hosts/nixos/options.nix`, then update the user definition.

```nix
# Example options.nix user configuration
mkUserOption = {
  isNormalUser = true;
  username = "yourusername"; # Replace with your username
  description = "Your user description";
  groups = ["wheel", "networkmanager"];
  shell = pkgs.zsh;
  home = "/home/yourusername"; # Must match actual home directory
  pkgs = with pkgs; [ ];
};
```

#### Setup hostname *(optional)*

If you wish to use another hostname instead of the default `nixos`, change

1. `flake.nix`: Under `nixosConfigurations` copy or edit the configuration with your desired hostname
2. In `hosts/nixos/configuration.nix` update entry `networking.hostName`
3. In `modules/nixos/settings/home-manager.nix` update variable `hostname`
4. Update hostname directory under `hosts/`

#### Setup hardware config

As hardware config will be different for every host, use the one generated during distro installation

> [!NOTE]
> If you changed hostname, use the one you defined instead of `nixos`

```bash
sudo copy -fv /etc/nixos/hardware-configuration.nix ./hosts/nixos/
```

#### Update flake *(optional)*

```nix
nix --extra-experimental-features nix-command --extra-experimental-features flakes flake lock
nix --extra-experimental-features nix-command --extra-experimental-features flakes flake update
```

#### Regarding the bootloader

> [!IMPORTANT]
> Bootloader configuration will be different for different NixOS setups, 
> it is recommened to copy definitions from `/etc/nixos/configuration.nix`
> to `./hosts/nixos/configuration.nix`

### Using the configuration

There are several operations you'll perform when making changes to your system, 
the three most common can be

* Apply changes to configuration
  * Switch: Creates a boot entry with the new changes and realizes them into the running system
  * Test: realizes changes into the running system without creating a boot entry
  * Boot: Creates a boot entry but does not realizes changes into the running system
  * Build: Compiles changes without creating boot a new boot entry nor realizing them into the running system
* Update the system
* Clean out old boot entries

> [!TIP]
> Refer to the
> [NixOS manual](https://nixos.org/manual/nixos/stable) and the
> [Nixpkgs manual](https://nixos.org/manual/nixpkgs/stable/)
> if in need of more information

#### With `nix` commands

##### Applying changes

```bash
# Create boot entry and apply to running system
nixos-rebuild switch --use-remote-sudo --flake ".#nixos"

# Do not create boot entry and apply to running system
nixos-rebuild test --use-remote-sudo --flake ".#nixos"

# Create boot entry and do not apply to running system
nixos-rebuild boot --use-remote-sudo --flake ".#nixos"

# Do not create boot entry and do not apply to running system
nixos-rebuild build --use-remote-sudo --flake ".#nixos"
```

> [!WARNING]
> *From the [NixOS manual](https://nixos.org/manual/nixos/stable/#sec-changing-config)*
> 
> Applying a configuration is an action that must be done by the root user,
> so the switch, boot and test commands should be ran with the --use-remote-sudo flag.
> Despite its odd name, this flag runs the activation script with elevated permissions,
> regardless of whether or not the target system is remote, without affecting the other stages of the nixos-rebuild call.
> This allows unprivileged users to rebuild the system and only elevate their permissions when necessary.
>
> Alternatively, one can run the whole command as root while preserving user environment variables by prefixing the command with sudo -E.
> However, this method may create root-owned files in $HOME/.cache if Nix decides to use the cache during evaluation.

##### Updating the system

> [!TIP]
> For more information see the [NixOS manual](https://nixos.org/manual/nixos/stable/#sec-upgrading)

Upgrade NixOS to the latest version in your chosen channel by running

```bash
sudo nixos-rebuild switch --upgrade --flake ".#nixos"
```

Or

```bash
sudo nix-channel --update
sudo nixos-rebuild switch --flake ".#nixos"
```

##### Cleaning out the system

> [!TIP]
> For more information see the [NixOS manual](https://nixos.org/manual/nixos/stable/#sec-nix-gc)

Remove old, unreferenced packages

```bash
nix-collect-garbage
```

Another way to reclaim disk space (often as much as 40% of the size of the Nix store) is to run Nix’s store optimiser, 
which seeks out identical files in the store and replaces them with hard links to a single copy.

```bash
nix-store --optimise
```

#### Using `nix-helper`

Apply the configuration

```bash
# Create boot entry and apply to running system
nh os switch

# Do not create boot entry and apply to running system
nh os test

# Create boot entry and do not apply to running system
nh os boot

# Do not create boot entry and do not apply to running system
nh os build
```

***

`nix-helper` is an utility layer atop `nix` that greatly simplifies managment.
It requires that the flake path be explicitly specified or set in an environment variable to work properlly.

You can find said configuration on [./modules/settings/nix-helper.nix](./modules/settings/nix-helper.nix).

> [!IMPORTANT]
> If your configuration lives anywhere else other than in your home directory (`~/username`),
> you'll need to update the enviroment variable.

```nix
{
  environment.sessionVariables = {
    FLAKE = "/home/yourusername/dotfiles"; # Replace with your dotfiles path
  };
}
```

> [!IMPORTANT]
> `nix-helper` matches your hostname definition in `networking.hostName` to the flake output names defined in `flake.nix`
> therefore output configuration names must match the hostname for correct operation.

##### Updating the system

> [!TIP]
> For more information see the [NixOS manual](https://nixos.org/manual/nixos/stable/#sec-upgrading)

Upgrade NixOS to the latest version in your chosen channel by running

```bash
sudo nix-channel --update
nh os switch
```

##### Cleaning out the system

> [!TIP]
> For more information see the [NixOS manual](https://nixos.org/manual/nixos/stable/#sec-nix-gc)
> and the `nh` help page 

Remove old unreferenced packages

```bash
nh clean all
```

If you wish to mantain `nix-shell` packages or dev environments, run

```bash
nh clean all --nogcroots
```

Another way to reclaim disk space (often as much as 40% of the size of the Nix store) is to run Nix’s store optimiser, 
which seeks out identical files in the store and replaces them with hard links to a single copy.

```bash
nix-store --optimise
```

### Customizing Your configuration

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
