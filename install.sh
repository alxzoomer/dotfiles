#!/bin/bash

case "$OSTYPE" in
  darwin*)  OS=OSX ;; 
  linux*)   OS=LINUX ;;
  *)        OS=unknown ;;
esac

if [ "${OS}" = "LINUX" ] ; then

sudo apt-get update
sudo apt-get -y install git zsh build-essential file zsh

git clone -b unified https://github.com/alxzoomer/dotfiles.git ~/dotfiles
. ~/dotfiles/utils/install_ubuntu.sh
fi

if [ "${OS}" = "OSX" ] ; then

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

. ~/dotfiles/utils/install_macos.sh
fi
