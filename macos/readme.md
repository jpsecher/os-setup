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

    $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    --cask docker
    alacritty
    alt-tab
    awscli
    bash-language-server
    bat
    duckduckgo
    eza
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
    rectangle
    roon
    signal
    slack
    taplo
    thunderbird
    tmux
    tree
    utm
    viscosity 
    terraform-ls
    terraform-lsp
    vlc
    watch
    zoxide

### Fonts

    brew install font-meslo-for-powerlevel10k

Then switch to using "MesloLGS NF Regular" as the Terminal font.

## Zsh

    export REPO=~/repos/others
    mkdir $REPO
    cd $REPO
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git
    ln -s ~/repos/personal/os-setup/macos/p10k.zsh ~/.p10k.zsh
    ln -s ~/repos/personal/os-setup/macos/zshrc ~/.zshrc

### QMK

    brew tap qmk/qmk
    brew install qmk
    qmk setup -H ~/repos/personal/qmk jpsecher/qmk_firmware

### Rust

    brew install rustup-init rust-analyzer
    rustup-init

## Downloads


## Config files

    export CONFIG=~/repos/personal/os-setup
    ln -sf $CONFIG/common/git/gitconfig ~/.gitconfig
    ln -sf $CONFIG/common/git/gitignore-global ~/.gitignore-global
    ln -sf $CONFIG/common/ssh/ssh-config ~/.ssh/config
    mkdir -p $(bat --config-dir)
    ln -sf $CONFIG/common/bat/config $(bat --config-dir)/config
    mkdir -p ~/.config/helix
    ln -sf $CONFIG/common/helix/config.toml ~/.config/helix
    ln -sf $CONFIG/common/helix/languages.toml ~/.config/helix
    mkdir -p ~/.config/alacritty
    ln -sf $CONFIG/common/alacritty/alacritty-medium.toml ~/.config/alacritty/alacritty.toml

## Python

    // pip3 install --upgrade pip

## Services

    sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

## DevEnv

    sh <(curl -L https://nixos.org/nix/install)
    (see devenv.sh)
