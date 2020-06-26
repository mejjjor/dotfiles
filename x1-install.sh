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

BASEDIR=$(cd "$(dirname "$0")"; pwd)


# trackpad driver
sudo apt install xserver-xorg-input-synaptics

safelink $BASEDIR/config-x1/70-synaptics.conf.default /usr/share/X11/xorg.conf.d/70-synaptics.conf.default
safelink $BASEDIR/config-x1/70-synaptics.conf /usr/share/X11/xorg.conf.d/70-synaptics.conf
