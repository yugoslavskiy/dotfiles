#!/bin/bash

printf "\n" "Updating Dotfiles"
cd "~/.dotfiles"
if git pull --rebase --stat origin master
then
  printf "\n" "Dotfiles has been updated and/or is at the current version."
else
  printf "\n" 'There was an error updating.'
fi
