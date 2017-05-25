# PetPenguin

PetPenguin is my custom configuration of Ubuntu 16.04 designed to run in VirtualBox on macOS hosts. It tries to mimic a “normal” GUI app running on your Mac. The primary purpose of this project is to provide an accessible virtual machine template for experimentation and running software native to Linux. The configuration is highly opinionated and is unlikely to be useful for anyone but myself. This is also the place where I store my dot-files.

PetPenguin is alpha software.

## Installation (Easy)

Requires [Vagrant](https://www.vagrantup.com) and [VirtualBox](https://www.virtualbox.org).

1. Clone this repo: `git clone git@github.com:temochka/PetPenguin.git`.
2. Open the clonned directory: `cd PetPenguin`.
3. Run `vagrant up`.
4. Run `vagrant reload` if you notice any issues after the installation.

## Installation (Advanced)

Requires [VirtualBox](https://www.virtualbox.org).

1. Create a new VirtualBox VM with the following settings:
  * 2048+ MB RAM, 2+ CPUs, 128 MB Video Memory (3D acceleration enabled);
  * enable KVM paravirtualization (VT-x/AMD-V, Nested Paging, PAE/NX);
  * for sound, select Core audio driver, Intel HD Audio;
  * enable bi-directional clipboard.
2. Install Ubuntu 16.04 Minimal.
3. Install VirtualBox Guest Additions.
4. Clone this repo: `git clone git@github.com:temochka/PetPenguin.git`.
5. Open the clonned directory: `cd PetPenguin`.
6. Run `./install_linux.sh`.

## Installing dot-files on Mac

1. Clone this repo: `git clone git@github.com:temochka/PetPenguin.git`.
2. Open the clonned directory: `cd PetPenguin`.
3. Run `./install_mac.sh`.

## Usage Instructions

### Shortcuts

Standard macOS shortcuts should work in the terminal and most GTK apps. Many host shortcuts should behave normally (e.g., spotlight, taking screenshots, switching between input sources, etc.).

| Shortcut | Action |
|------------|----------|
| <kbd>⌘</kbd>+<kbd>1</kbd>, ..., <kbd>⌘</kbd>+<kbd>0</kbd> | Switch between IDE tabs.
| <kbd>⌘</kbd>+<kbd>Shift</kbd>+<kbd>1</kbd> ..., <kbd>⌘</kbd>+<kbd>Shift</kbd>+<kbd>0</kbd> | Move current panel to the specified tab.
| <kbd>⌘</kbd>+<kbd>Shift</kbd>+<kbd>Enter</kbd> | Run a terminal ([st](http://st.suckless.org)+[tmux](https://tmux.github.io)).
| <kbd>⌘</kbd>+<kbd>J</kbd> | Select the next panel.
| <kbd>⌘</kbd>+<kbd>K</kbd> | Select the previous panel.
| <kbd>⌘</kbd>+<kbd>Enter</kbd> | Expand the selected panel.
| <kbd>⌘</kbd>+<kbd>Shift</kbd>+<kbd>W</kbd> | Close the selected panel.
| <kbd>⌥</kbd>+<kbd>Shift</kbd>+<kbd>Space</lbd> | Show the application launcher ([dmenu](http://tools.suckless.org/dmenu/)).
| <kbd>⌘</kbd>+<kbd>+</kbd> | Widen the expanded panel.
| <kbd>⌘</kbd>+<kbd>-</kbd> | Shrink the expanded panel.
| <kbd>⌘</kbd>+<kbd>Shift</kbd>+<kbd>+</lbd> | Disable the expanded panel (makes all panels equal).
| <kbd>⌘</kbd>+<kbd>Shift</kbd>+<kbd>-</lbd> | Enable the expanded panel (default).
| <kbd>⌥</kbd>+<kbd>Shift</kbd>+<kbd>Q</kbd> | Restart the UI (X11).

### Useful Utilities

#### pbcopy

Good old `pbcopy` that works between the host and the guest VM. Put any terminal output to to the clipboard by running `echo "anything" | pbcopy`.

#### impostor

Most Linux apps will use the `$BROWSER` environment variable to determine your current browser. Unless you want to run the browser inside the VM (can be installed from APT), impostor will attempt to SSH to the host (assumed to be at 192.168.42.1 or specified via the `$MACOS_SSH_HOSTNAME` environment variable) and open the URL in Safari. Any local URLs will be opened in [Surf](http://surf.suckless.org).
