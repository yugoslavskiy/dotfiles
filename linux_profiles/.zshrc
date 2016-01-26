## ln -sfv "/media/psf/Dropbox/dotfiles/linux_profiles/.zshrc" ~
## ln -sfv "~/.dotfiles/linux_profiles/.zshrc" ~

## Initial path variable setup
export PATH=$HOME:$PATH

## yeap.
ZSH_THEME="fox"

## Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

## Export zsh initial script.
source $ZSH/oh-my-zsh.sh

## Path to dotfiles directory.
## export DOTFILES_DIR=/media/psf/Dropbox/projects/dotfiles
export DOTFILES_DIR=$HOME/.dotfiles

## Exporting system-specific environment.
export FPATH=$ZSH/custom/plugins/zsh-completions/src:$FPATH
source $DOTFILES_DIR/system/.env

# Some zsh plugins.
plugins=(pip python git zsh-completions zsh-syntax-highlighting)

## Autoload completions.
autoload -U compinit && compinit

## Turns on interactive comments; comments begin with a #.
setopt interactivecomments

## Forces the user to type exit or logout, instead of just pressing ^D.
setopt ignoreeof

## Lets files beginning with a . be matched without explicitly specifying the dot.
setopt globdots

## Prevents you from accidentally overwriting an existing file.
## If you really do want to clobber a file, you can use the >! operator. 
setopt noclobber
