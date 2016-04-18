## Linux profile

## initial path variable setup
export PATH=$HOME:$PATH

## yeap
ZSH_THEME="fox"

## path to your oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

## path to dotfiles directories
export LINUX_DOTFILES_DIR=$HOME/.dotfiles/Linux/system
export COMMON_DOTFILES_DIR=$HOME/.dotfiles/Common/dotfiles

## fpath for completions
export FPATH=$ZSH/custom/plugins/zsh-completions/src:$FPATH

## system-specific & common dotfiles
for DOTFILE in $( find $LINUX_DOTFILES_DIR && find $COMMON_DOTFILES_DIR ) ; do
  [ -r "$DOTFILE" ] && [ -f "$DOTFILE" ] && source "$DOTFILE";
done

unset DOTFILE;
unset LINUX_DOTFILES_DIR;
unset COMMON_DOTFILES_DIR;

## autoload completions for plugins
autoload -U compinit && compinit

## zsh plugins
plugins=(pip python git tmux colorize zsh-completions zsh-syntax-highlighting)

## export zsh initial script
source $ZSH/oh-my-zsh.sh

## turns on interactive comments; comments begin with a #
setopt interactivecomments

## forces the user to type exit or logout, instead of just pressing ^D.
setopt ignoreeof

## lets files beginning with a . be matched without explicitly specifying the dot
setopt globdots
