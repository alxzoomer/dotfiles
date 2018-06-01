#!/bin/bash

your_name="Your Name"
your_email=your@email.com

git config --global color.ui true
git config --global user.name "$your_name"
git config --global user.email "$your_email"
cp ~/.gitconfig ~/.gitconfig.local
ssh-keygen -t rsa -C "$your_email"

cat ~/.ssh/id_rsa.pub

echo Paste it here https://github.com/settings/ssh
