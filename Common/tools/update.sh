#!/bin/bash

printf "Updating Dotfiles\n"
cd ~/.dotfiles
if git pull --rebase --stat origin master
then
  cp "$(uname -s)"/profile/.zshrc ~/.zshrc
  printf "Dotfiles has been updated and/or is at the current version.\n"
else
  printf "There was an error updating.\n"
fi