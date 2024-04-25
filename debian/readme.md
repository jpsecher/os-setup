# Debian/Ubuntu setup from scratch

## Zsh

    sudo wget -P /usr/local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
    sudo wget -P /usr/local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
    sudo wget -P /usr/local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
    sudo wget -P /usr/local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
    fc-cache -fv
    
    sudo apt install -y zsh
    export REPO=~/repos/others
    mkdir $REPO
    cd $REPO
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git
    echo "source $REPO/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
