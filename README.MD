# My dotfiles

# Prerequisites

## Mac OS
  * [Brew](https://brew.sh/)
  * Git
     ```sh
      brew install git
    ```

## Linux
Install `git` and `zsh`.
```sh
sudo apt-get update
sudo apt-get install git zsh build-essential file
```

# Common
  * [Vim Vundle](https://github.com/VundleVim/Vundle.vim#quick-start)

# Configure GIT
```sh
curl https://raw.githubusercontent.com/alxzoomer/dotfiles/master/configure_git.sh --output configure_git.sh
vim configure_git.sh
```
Edit `your_name` and `your_email` fields.
```sh
chmod +x configure_git.sh
./configure_git.sh
```

# Installation

## Oh-my-zsh
Follow instructions on [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) git repository.

## Dot files
```sh
cd
git clone --recursive git@github.com:alxzoomer/dotfiles.git
cd dotfiles
chmod +x setup.sh
./setup.sh
```

# Update submodules
```sh
cd ~/dotfiles/shell/custom/plugins/zsh-autosuggestions
git pull origin master
cd ~/dotfiles
git status
git add shell/custom/plugins/zsh-autosuggestions
git commit -m "Update zsh-autosuggestions"

cd ~/dotfiles/shell/custom/plugins/zsh-peco-history
git pull origin master
cd ~/dotfiles
git status
git add shell/custom/plugins/zsh-peco-history
git commit -m "Update zsh-peco-history"

cd ~/dotfiles/shell/custom/plugins/spaceship-prompt
git pull origin master
cd ~/dotfiles
git status
git add shell/custom/plugins/spaceship-prompt
git commit -m "Update spaceship-prompt"

git push
```