# MacOS setup from scratch

## System Preferences:

- Track Pad: Tap to click, etc.
- Accessibility: Three finger drag
- Keyboard: Use function keys, Modifier keys, etc.
- Sharing: computer name
- Desktop: Hot corners.

    scutil --set HostName myhostname
    defaults write com.apple.screencapture disable-shadow true

## Packages/Casks

    $ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    --cask docker
    alacritty
    alt-tab
    awscli
    bat
    duckduckgo
    fzf
    glances
    google-drive
    helix 
    just
    keepassxc
    kicad
    ltspice
    maccy
    marksman
    neofetch
    obsidian
    openscad
    roon
    signal
    skitch
    slack
    taplo
    thunderbird
    tmux
    tree
    utm
    viscosity 
    terraform-lsp
    vlc
    watch

### Fonts

    brew tap homebrew/cask-fonts
    brew install font-meslo-for-powerlevel10k

Then switch to using "MesloLGS NF Regular" as the Terminal font.

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
    mkdir -p ~/.config/helix
    ln -sf $CONFIG/common/helix/config.toml ~/.config/helix
    ln -sf $CONFIG/common/helix/languages.toml ~/.config/helix
    mkdir -p ~/.config/alacritty
    ln -sf $CONFIG/common/alacritty/alacritty.toml ~/.config/alacritty

## Python

    // pip3 install --upgrade pip

## Services

    sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

## DevEnv

    sh <(curl -L https://nixos.org/nix/install)
    (see devenv.sh)
