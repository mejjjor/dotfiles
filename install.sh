#!/bin/sh

[[ "$1" == "-f" ]] && FORCE=true
SKIP=false

platformlink() {
  target=$1
  link=$2

  ln -sfFT $target $link
}

safelink()
{
  $SKIP && return

  target=$1
  link=$2

  if [ $FORCE ]; then
    DO_LINK=true
  else
    if [ -d $link -o -f $link ]; then
      DO_LINK=false

      echo -n "$(tput setaf 3)'$link' already exists, do you want to replace it? ([y]es/[N]o/[a]ll/[s]kip) $(tput sgr0)"

      read answer
      case $answer in
        "yes"|"y")
          DO_LINK=true
          ;;
        "all"|"a")
          FORCE=true
          DO_LINK=true
          ;;
        "skip"|"s")
          SKIP=true
          return
          ;;
        *)
          DO_LINK=false
          ;;
      esac
    else
      DO_LINK=true
    fi
  fi

  $DO_LINK && platformlink $target $link
}

safeinstall() {
  package=$1

    sudo apt install $package
}

BASEDIR=$(cd "$(dirname "$0")"; pwd)


# -- [[ Linking ]] -------------------------------------------------------------
echo "Linking configuration files..."
# .config directories
[[ -d ~/.config ]] || mkdir ~/.config
# copy folder tree

cp -as $BASEDIR/.config ~/ 


safelink $BASEDIR/.gitconfig $HOME/.gitconfig
safelink $BASEDIR/.gitignore $HOME/.gitignore
safelink $BASEDIR/.zshrc $HOME/.zshrc
safelink $BASEDIR/.p10k.zsh $HOME/.p10k.zsh


# -- [[ Package / plugins installation ]] --------------------------------------
echo
echo -n "Do you want to check packages? ([y]es/[N]o) "

read answer
case $answer in
  "yes"|"y")
    safeinstall curl

    safeinstall i3xrocks-battery
    safeinstall i3xrocks-memory
    safeinstall i3xrocks-wifi
    safeinstall i3xrocks-temp

    safeinstall htop
    safeinstall xcwd

    safeinstall vim
    safeinstall zsh

    sudo snap install vlc
    sudo snap install sublime-text --classic

    sudo apt install nomachine
    sudo apt install gnome-shell-extensions-gpaste gpaste
    sudo apt install fzf
    sudo apt install bat

    # firefox video driver
    sudo apt install libavcodec-extra

    # vlc codec mp4 (and more maybe...)
    sudo apt install libdvdnav4 libdvd-pkg gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly libdvd-pkg
    sudo apt install ubuntu-restricted-extras

    # vscode
    sudo apt install software-properties-common apt-transport-https wget
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt update
    sudo apt install code
    
    # regolight
    sudo add-apt-repository ppa:regolith-linux/release
    sudo apt install regolith-desktop i3xrocks-net-traffic i3xrocks-cpu-usage i3xrocks-time

    # nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
    # node / npm by nvm 
    nvm install node
    npm i -g yarn

    # oh-my-zsh
    curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash

    # oh-my-zsh plugins
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

    # google-chrome
    sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install google-chrome-stable

    # android
    sudo apt install android-sdk
    sudo apt-get install openjdk-8-jdk  

    # docker
    sudo apt install docker
    sudo apt install docker-compose

    echo "$(tput setaf 2)All dependencies are up to date$(tput sgr0)"
    ;;
  *)
    echo "$(tput setaf 3)Packages update skipped$(tput sgr0)"
    ;;
esac


sudo chsh -s /bin/zsh
