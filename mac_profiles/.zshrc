## ln -sfhv "/Users/yugoslavskiy/Dropbox/dotfiles/mac_profiles/.zshrc" ~

## yeap.
ZSH_THEME="af-magic"

## Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

## Export zsh initial script.
source $ZSH/oh-my-zsh.sh

## Path to dotfiles directory.
export DOTFILES_DIR=$HOME/Dropbox/dotfiles

## Exporting system-specific environment and features
export FPATH=$ZSH/custom/plugins/zsh-completions/src:$FPATH
source $DOTFILES_DIR/system/.env
#source $DOTFILES_DIR/mac_profiles/osxdefaults.sh

## Autoload completions for plugins.
autoload -U compinit && compinit

# Some zsh plugins.
plugins=(brew osx pip python git zsh-completions zsh-syntax-highlighting)

## fasd config.
eval "$(fasd --init posix-alias zsh-hook zsh-ccomp zsh-wcomp)"

## Turns on interactive comments; comments begin with a #.
setopt interactivecomments

## Forces the user to type exit or logout, instead of just pressing ^D.
setopt ignoreeof

## Lets files beginning with a . be matched without explicitly specifying the dot.
setopt globdots

## Prevents you from accidentally overwriting an existing file.
## If you really do want to clobber a file, you can use the >! operator. 
setopt noclobber
