#!/bin/bash
dir=$HOME
dir_backup=$HOME/dotfiles_old_$(date +%Y_%m_%d_%H-%M-%S)

declare -a FILES_TO_SYMLINK=(
  'git/gitconfig'
  'git/gitignore_global'

  'shell/zshrc'
  'shell/tmux.conf'
  'shell/psqlrc'
  'shell/tmux-powerlinerc'
  'shell/custom.sh:.tmux/themes/tmux-powerline/themes'

  'mc/hotlist:.config/mc/hotlist'
  'mc/ini:.config/mc/ini'
  'mc/menu:.config/mc/menu'
  'mc/panels.ini:.config/mc/panels.ini'

  'vim/vimrc'
)

declare -a DIRECTORIES_TO_SYMLINK=(
  'shell/custom'
  'mc/skins:.local/share/mc/skins'
  'vim/colors:.vim/colors'
)

# Create dotfiles_old in homedir
echo -n "Creating $dir_backup for backup of any existing dotfiles in '${dir}"
mkdir -p $dir_backup
echo "' done"

get_to_name() {
  local to_name=$(printf "%s" "$1"  | sed -En "s/(.*):.*/\1/p")
  if [ -z $to_name ] ; then 
    echo "$1"
  else
    echo "$to_name"
  fi
}

get_from_name() {
  local from_name=$(printf "%s" "$1" | sed -En "s/.*:(.*)/\1/p")
  if [ -z $from_name ] ; then 
    echo ".$(basename $1)"
  else
    echo "$from_name"
  fi
}

copy_file() {
  local sourceFile="$dir/$(get_from_name $1)"
  local targetFile="$dir_backup/$(get_to_name $1)"
  echo "Create dir $(dirname $targetFile)"
  mkdir -p "$(dirname $targetFile)"
  echo "Copy from $sourceFile to $targetFile"
  cp -R $sourceFile "$targetFile"
}

main() {
  echo "Backup files"
  for i in ${FILES_TO_SYMLINK[@]}; do
    copy_file $i
  done

  echo "Backup directories"
  for i in ${DIRECTORIES_TO_SYMLINK[@]}; do
    copy_file $i
  done

  unset FILES_TO_SYMLINK
  unset DIRECTORIES_TO_SYMLINK
}

main
