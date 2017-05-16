# Highly opinionated CLI toolkit

Nothing to see here.

## Installation on Linux

* VirtualBox settings:
  * RAM: 2048+ MB RAM
  * CPU: 2+ CPUs
  * 128 MB Video Memory, 3D acceleration enabled
  * Virtualization Options: KVM paravirtualization (VT-x/AMD-V, Nested Paging, PAE/NX)
  * Audio: Core audio driver, Intel HD Audio
  * Network:
    * Adapter 1: Intel PRO/1000 MT Desktop (NAT)
    * Adapter 2: Paravirtualized Network (Host-only, 192.168.42.0/255)
  * Other features:
    * Bi-directional clipboard
* Install Ubuntu 16.04 Minimal.
* Install VirtualBox Guest Additions
* Install `openssh-server`.
* Install SSH key pair.
* Install Git.
* Clone this repo.
* Run `linux_install.sh`.
* ...
* PROFIT! (at this point it doesn't work, probably)

Possibly useful config:

```
# /etc/network/interfaces
# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth1
iface eth1 inet dhcp
pre-up sleep 2

# The host-only network interface
# auto eth1
auto eth0
iface eth0 inet static
address 192.168.42.42
netmask 255.255.255.0
```

## Details (Linux)

* slim session manager with custom HiDPI theme (auto-login enabled)
* dwm window manager
* st terminal (tmux for scrolling and text reflow)
* dmenu app launcher
* solarized colors
* poor, optional HiDPI support held on duct tape
* OS X shortcuts for copy-paste
* (maybe) useful utilities:
  * `impostor` - pretend browser that opens remote URLs with default browser on the host machine and local URLs with `surf`.
  * `git-web` - git extension that prints a web URL for a repo hosted on Github or Beanstalk.
  * `pbcopy` - `xclip` wrapper that works similarly to its OS X namesake.

## Details (OS X)

Read the source.

