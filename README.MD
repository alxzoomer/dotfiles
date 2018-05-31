# My dotfiles

# Prerequisites

## Mac OS
  * [Brew](https://brew.sh/)
  * Git
     ```sh
      brew install git
    ```

## Linux
```sh
sudo apt-get update
sudo apt-get install git
```

# Common
  * [Vim Vundle](https://github.com/VundleVim/Vundle.vim#quick-start)

# Configure GIT
```sh
curl https://raw.github.com/alxzoomer/repository/master/configure_git.sh --output configure_git.sh
vim configure_git.sh
```

# Installation
```sh
cd
git clone --recursive git@github.com:alxzoomer/dotfiles.git
cd dotfiles
chmod +x setup.sh
./setup.sh
```
