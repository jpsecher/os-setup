# MacOS setup from scratch

## System Preferences:

    * Track Pad: Tap to click, etc.
    * Accessibility: Three finger drag
    * Keyboard: Use function keys, Modifier keys, etc.
    * Sharing: computer name
    * Desktop: Hot corners.

    scutil --set HostName fowler

## Packages

    $ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    $ eval "$(/opt/homebrew/bin/brew shellenv)"

    python3
    bat
    helix 
    coreutilsi 
    wget
    tree
    fzf
    ansible

### Casks

    google-drive
    brave-browser 
    obsidian
    signal
    thunderbird
    docker
    slack
    ltspice
    roon
    skitch
    viscosity 
    scroll-reverser
    maccy
    utm

### Fonts

    brew tap homebrew/cask-fonts
    brew install font-ubuntu-mono-nerd-font

## Downloads

    https://alt-tab-macos.netlify.app/

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
