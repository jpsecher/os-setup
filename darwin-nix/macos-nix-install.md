See first: https://github.com/dustinlyons/nixos-config


scutil --set HostName shamir
(In Sharing, change hostname to shamir)

Run curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

new shell

mkdir nix-darwin-config
cd nix-darwin-config

nix flake init -t nix-darwin (which makes flake.nix)

Edit flake
- change vim to helix
- change "simple" to "shamir"
- change arch to aarch64-darwin

nix run nix-darwin -- switch --flake .

add to flake:

security.pam.enableSudoTouchIdAuth = true;

darwin-rebuild switch --flake . 

reboot

softwareupdate --install-rosetta --agree-to-license

Add to flake:

nix.extraOptions = ''
  extra-platforms = x86_64-darwin aarch64-darwin
'';

## Update the system

nix flake update
darwin-rebuild switch --flake . 

If in git repo:
nix flake update --commit-lock-file

## On next new system

    scutil --set HostName lamport
    xcode-select --install
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    mkdir -p ~/repos/personal
    cd ~/repos/personal
    git clone git@github.com:jpsecher/os-setup.git
    cd os-setup/darwin-nix/host
    mkdir lamport
    cp shamir/flake.nix lamport/
    cd lamport
    uname -m
    vi flake.nix

Edit to use the right arch and host name.

    nix run nix-darwin -- switch --flake .#hostname


## MacOS defaults

https://github.com/LnL7/nix-darwin/tree/master/modules/system/defaults

https://github.com/andreivolt/nixos-config/blob/master/darwin-configuration.nix

## Update the system

    nix flake update
    darwin-rebuild switch --flake .#shamir

## Cleanup

    nix-collect-garbage -d

## Specific versions of packages

https://lazamar.co.uk/nix-versions/

https://www.nixhub.io

## Trouble shooting

Keyboard disconnected after sleep: https://tosbourn.com/usb-disconnects-macos/
