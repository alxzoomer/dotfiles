#!/bin/bash
INSTALL_ROOT=$HOME
DOTFILES_ROOT=$INSTALL_ROOT/dotfiles
VIM_ROOT=$INSTALL_ROOT/.vim

if [ -z $OSTYPE ] ; then
  OSTYPE="$(uname -o)"
fi

case "$OSTYPE" in
  darwin*)  OS=OSX ;; 
  linux*)   OS=LINUX ;;
  Linux*)   OS=LINUX ;;
  *)        OS=unknown ;;
esac

echo "Install prerequisites for ${OS}"

if [ "${OS}" = "LINUX" ] ; then
  case "$(uname -o)" in
    Android*) OS_TYPE=ANDROID ;;
    *)        OS_TYPE=LINUX ;;
  esac

  echo "OS is ${OS} and OS type is ${OS_TYPE}"

  if [ "${OS_TYPE}" = "LINUX" ] ; then
    LINUX_ID=`awk -F '=' '/^ID=/ { print $2 }' /etc/os-release | tr -d \"`
    if [ "${LINUX_ID}" = "centos" ] ; then
      echo "Install centos packages"
      # Note: Uncomment when required latest packages
      #sudo yum update

      # Minimalistic package set for ubuntu
      sudo yum -y install file mc vim
      # Note: uncomment for SF development
      #sudo yum groupinstall -y 'Development Tools'
      #sudo yum -y install libcap-devel texi2html texinfo 

      # Download source RPM zsh 5.5.1 from Fefora Core repo
      #curl http://dl.fedoraproject.org/pub/fedora/linux/updates/28/Everything/SRPMS/Packages/z/zsh-5.5.1-1.fc28.src.rpm --output ~/zsh-5.5.1-1.fc28.src.rpm
      #rpmbuild --rebuild ~/zsh-5.5.1-1.fc28.src.rpm
      #sudo rpm -ivh ~/rpmbuild/RPMS/x86_64/zsh-5.5.1-1.el7.x86_64.rpm
      #rm -rf ~/rpmbuild
      #rm ~/zsh-5.5.1-1.fc28.src.rpm
      curl http://mirror.ghettoforge.org/distributions/gf/gf-release-latest.gf.el7.noarch.rpm -o gf-release-latest.gf.el7.noarch.rpm
      sudo rpm -Uvh gf-release*rpm
      rm gf-release-latest.gf.el7.noarch.rpm
      sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
      sudo yum -y install epel-release
      sudo rpm -Uvh https://centos7.iuscommunity.org/ius-release.rpm
      sudo yum -y --enablerepo=gf-plus install tmux zsh git2u
    fi
    if [ "${LINUX_ID}" = "ubuntu" ] ; then
      echo "Install ubuntu packages"
      sudo apt-get update
      # Minimalistic package set for ubuntu
      sudo apt-get -y install git zsh build-essential file tmux mc vim
    fi
    if [ "${LINUX_ID}" = "alpine" ] ; then
      echo "Install alpine packages"
      apk update
      apk add zsh git bash zsh zsh-vcs tmux mc vim
    fi
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
  brew install peco
  brew install vim
fi

# Dotfiles itself
git clone https://github.com/alxzoomer/dotfiles.git $DOTFILES_ROOT
# Spaceship theme for Oh my ZSH
git clone https://github.com/denysdovhan/spaceship-prompt.git $DOTFILES_ROOT/shell/custom/themes/spaceship-prompt
# Powerlevel9k theme for Oh my ZSH
git clone https://github.com/bhilburn/powerlevel9k.git $DOTFILES_ROOT/shell/custom/themes/powerlevel9k
# ZSH autosuggestion custom plugin
git clone https://github.com/zsh-users/zsh-autosuggestions.git $DOTFILES_ROOT/shell/custom/plugins/zsh-autosuggestions
# ZSH peco history plugin
git clone https://github.com/jimeh/zsh-peco-history.git $DOTFILES_ROOT/shell/custom/plugins/zsh-peco-history
# VIM Vundle plugin
git clone https://github.com/VundleVim/Vundle.vim.git $VIM_ROOT/bundle/Vundle.vim
# Install Oh my ZSH
git clone https://github.com/robbyrussell/oh-my-zsh.git $INSTALL_ROOT/.oh-my-zsh

$(which bash) $DOTFILES_ROOT/setup.sh

# Install VIM Plugins and exit when Vundle.vim is in default directory
if [ -d "$HOME/.vim/bundle/Vundle.vim" ] ; then
  echo "Installing VIM plugins"
  vim -T dumb -n -c "set nomore" -c "PluginInstall" -c "qall"
  echo "VIM plugins installed"
fi

# Final step change default shell to ZSH
echo "Switch shell to ZSH"
chsh -s $(which zsh)
