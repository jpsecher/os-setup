# MacOS setup from scratch

## System Preferences:

    * Track Pad: Tap to click, etc.
    * Accessibility: Three finger drag
    * Keyboard: Use function keys, Modifier keys, etc.
    * Sharing: computer name
    * Desktop: Hot corners.

    scutil --set HostName fowler

## Packages/Casks

    $ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    bat
    helix 
    // coreutils
    // wget
    tree
    fzf
    // ansible
    google-drive
    chromium
    obsidian
    signal
    thunderbird
    --cask docker
    slack
    // ltspice
    roon
    // skitch
    viscosity 
    // scroll-reverser
    maccy
    alt-tab
    utm
    vlc
    glances
    taplo
    just
    watch

### Fonts

    brew tap homebrew/cask-fonts
    // brew install font-ubuntu-mono-nerd-font
    // brew install font-meslo-for-powerlevel10k
    brew install --cask font-hack-nerd-font

### QMK

    brew tap qmk/qmk
    brew install qmk

### Rust

    brew install rust-up rust-analyzer
    rustup-init

## Downloads

## Zsh

    export REPO=~/repos/others
    mkdir $REPO
    cd $REPO
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git
    echo "source $REPO/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc

## Config files

    export CONFIG=~/repos/personal/os-setup
    ln -sf $CONFIG/common/git/gitconfig ~/.gitconfig
    ln -sf $CONFIG/common/git/gitignore-global ~/.gitignore-global
    ln -sf $CONFIG/common/ssh/ssh-config ~/.ssh/config_file
    mkdir -p $(bat --config-dir)
    ln -sf $CONFIG/common/bat/config $(bat --config-dir)/config

## Python

    pip3 install --upgrade pip

## Services

    sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

## DevEnv

    sh <(curl -L https://nixos.org/nix/install)
    (see devenv.sh)
