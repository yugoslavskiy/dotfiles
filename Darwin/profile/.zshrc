## OSX profile

## initial path variable setup
export PATH=$HOME:$PATH

## yeap
ZSH_THEME="fox"

## path to your oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

## path to dotfiles directories
export OSX_DOTFILES_DIR=$HOME/.dotfiles/Darwin/system
export COMMON_DOTFILES_DIR=$HOME/.dotfiles/Common/dotfiles

## fpath for completions
export FPATH=$ZSH/custom/plugins/zsh-completions/src:$FPATH

## system-specific & common dotfiles
for DOTFILE in $( find $OSX_DOTFILES_DIR $COMMON_DOTFILES_DIR -type f ) ; do
  [ -r "$DOTFILE" ] && [ -f "$DOTFILE" ] && source "$DOTFILE";
done

unset DOTFILE;
unset OSX_DOTFILES_DIR;
unset COMMON_DOTFILES_DIR;

## autoload completions for plugins
autoload -U compinit && compinit

# zsh plugins
plugins=(brew osx pip python git tmux colorize zsh-completions vagrant docker)

## export zsh initial script
source $ZSH/oh-my-zsh.sh

## turns on interactive comments; comments begin with a #
setopt interactivecomments

## forces the user to type exit or logout, instead of just pressing ^D.
setopt ignoreeof

## lets files beginning with a . be matched without explicitly specifying the dot.
setopt globdots

## zsh-syntax-highlighting plugin
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## fucking ruby versioning staff
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi