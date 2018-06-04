#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] ; then
  echo "Specify GIT user name and email."
  echo "Example: \$configure_git.sh \"Ivan Ivanov\" ivan.ivanov@example.com"
  exit 1
fi

your_name="$1"
your_email=$2

git config --global color.ui true
git config --global user.name "$your_name"
git config --global user.email "$your_email"
ssh-keygen -t rsa -C "$your_email"

cat ~/.ssh/id_rsa.pub

echo Paste it here https://github.com/settings/ssh
