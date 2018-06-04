#!/bin/bash
INSTALL_ROOT=$HOME
DOTFILES_ROOT=$INSTALL_ROOT/dotfiles
VIM_ROOT=$INSTALL_ROOT/.vim

case "$OSTYPE" in
  darwin*)  OS=OSX ;; 
  linux*)   OS=LINUX ;;
  *)        OS=unknown ;;
esac

echo "Install prerequisites"

if [ "${OS}" = "LINUX" ] ; then
  case "$(uname -o)" in
    Android*) OS_TYPE=ANDROID ;;
    *)        OS_TYPE=LINUX ;;
  esac

  echo "OS is ${OS} and OS type is ${OS_TYPE}"

  if [ "${OS_TYPE}" = "LINUX" ] ; then
    echo "Install ubuntu packages"
    sudo apt-get update
    # Minimalistic package set for ubuntu
    sudo apt-get -y install git zsh build-essential file tmux mc
  fi

  if [ "${OS_TYPE}" = "ANDROID" ] ; then
    echo "Install android Termux packages"
    # Minimalistic package set for Termux
    pkg install zsh file git mc ncurses-utils openssh tmux vim
  fi
fi

if [ "${OS}" = "OSX" ] ; then
  echo "Install OSX Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  echo "Install MacOS packages"
  # Minimalistic package set for MacOS X
  brew install git
  brew install zsh
fi

# Dotfiles itself
git clone -b unified https://github.com/alxzoomer/dotfiles.git $DOTFILES_ROOT
# Spaceship theme for Oh my ZSH
git clone https://github.com/denysdovhan/spaceship-prompt.git $DOTFILES_ROOT/shell/custom/themes/spaceship-prompt
# ZSH autosuggestion custom plugin
git clone https://github.com/zsh-users/zsh-autosuggestions.git $DOTFILES_ROOT/shell/custom/plugins/zsh-autosuggestions
# ZSH peco history plugin
git clone https://github.com/jimeh/zsh-peco-history.git $DOTFILES_ROOT/shell/custom/plugins/zsh-peco-history
# VIM Vundle plugin
git clone https://github.com/VundleVim/Vundle.vim.git $VIM_ROOT/bundle/Vundle.vim
# Install Oh my ZSH
git clone https://github.com/robbyrussell/oh-my-zsh.git $INSTALL_ROOT/.oh-my-zsh

. $DOTFILES_ROOT/setup.sh

# Install VIM Plugins and exit when Vundle.vim is in default directory
if [ -d "$HOME/.vim/bundle/Vundle.vim" ] ; then
  echo "Installing VIM plugins"
  vim -es -c PluginInstall
  echo "VIM plugins installed"
fi

# Final step change default shell to ZSH
echo "Switch shell to ZSH"
chsh -s $(which zsh)
