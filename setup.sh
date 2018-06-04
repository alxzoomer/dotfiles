#!/bin/bash

# Backup all files before set-up
script_path="`( cd \"$(dirname \"$0\")\" && pwd )`"
pushd $script_path
. ./backup.sh
popd

dir=$script_path
target_dir=$HOME

declare -a FILES_TO_SYMLINK=(
  'git/gitconfig'
  'git/gitignore_global'

  'shell/zshrc'
  'shell/tmux.conf'
  'shell/psqlrc'

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

get_from_name() {
  local from_name=$(printf "%s" "$1"  | sed -En "s/(.*):.*/\1/p")
  if [ -z $from_name ] ; then 
    echo "$1"
  else
    echo "$from_name"
  fi
}

get_to_name() {
  local to_name=$(printf "%s" "$1" | sed -En "s/.*:(.*)/\1/p")
  if [ -z $to_name ] ; then 
    echo ".$(basename $1)"
  else
    echo "$to_name"
  fi
}

link_file() {
  local sourceFile="$dir/$(get_from_name $1)"
  local targetFile="$target_dir/$(get_to_name $1)"
  mkdir -p "$(dirname $targetFile)"
  if [ -e $targetFile ]; then
    echo "Remove target file or directory $targetFile"
    rm -rf $targetFile
  fi
  echo "Link from $sourceFile to $targetFile"
  ln -s $sourceFile $targetFile
}

main() {
  echo "Link files"
  for i in ${FILES_TO_SYMLINK[@]}; do
    link_file $i
  done

  echo "Link directories"
  for i in ${DIRECTORIES_TO_SYMLINK[@]}; do
    link_file $i
  done

  unset FILES_TO_SYMLINK
  unset DIRECTORIES_TO_SYMLINK
}

main
