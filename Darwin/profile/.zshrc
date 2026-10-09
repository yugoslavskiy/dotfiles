## OSX profile

## initial path variable setup
export PATH=$HOME:$PATH

## Homebrew: /opt/homebrew on Apple Silicon, /usr/local on Intel
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

## yeap
ZSH_THEME="fox"

## path to your oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

## fpath for completions
export FPATH=$ZSH/custom/plugins/zsh-completions/src:$FPATH

# subl path
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

## path to dotfiles directories
export OSX_DOTFILES_DIR=$HOME/.dotfiles/Darwin/system
export COMMON_DOTFILES_DIR=$HOME/.dotfiles/Common/dotfiles
#
## system-specific & common dotfiles
# for DOTFILE in $( find $OSX_DOTFILES_DIR $COMMON_DOTFILES_DIR -type f ) ; do
#   [ -r "$DOTFILE" ] && [ -f "$DOTFILE" ] && source "$DOTFILE";
# done
#
# unset DOTFILE;
# unset OSX_DOTFILES_DIR;
# unset COMMON_DOTFILES_DIR;
#
# NEW OPTIMISED
# 
# Darwin/system
[ -r "$OSX_DOTFILES_DIR/.alias" ]     && source "$OSX_DOTFILES_DIR/.alias"
[ -r "$OSX_DOTFILES_DIR/.cleaning" ]  && source "$OSX_DOTFILES_DIR/.cleaning"
[ -r "$OSX_DOTFILES_DIR/.defensive" ] && source "$OSX_DOTFILES_DIR/.defensive"
[ -r "$OSX_DOTFILES_DIR/.env" ]       && source "$OSX_DOTFILES_DIR/.env"
[ -r "$OSX_DOTFILES_DIR/.function" ]  && source "$OSX_DOTFILES_DIR/.function"
[ -r "$OSX_DOTFILES_DIR/.offensive" ] && source "$OSX_DOTFILES_DIR/.offensive"

# Common dotfiles
[ -r "$COMMON_DOTFILES_DIR/.aliases" ]   && source "$COMMON_DOTFILES_DIR/.aliases"
[ -r "$COMMON_DOTFILES_DIR/.functions" ] && source "$COMMON_DOTFILES_DIR/.functions"

# Cleanup
unset OSX_DOTFILES_DIR
unset COMMON_DOTFILES_DIR

# zsh plugins
plugins=(brew macos pip python git tmux colorize zsh-completions)

## export zsh initial script
source $ZSH/oh-my-zsh.sh

## turns on interactive comments; comments begin with a #
setopt interactivecomments

## forces the user to type exit or logout, instead of just pressing ^D.
setopt ignoreeof

## lets files beginning with a . be matched without explicitly specifying the dot.
setopt globdots

## zsh-syntax-highlighting plugin
[ -r "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# ПЕРЕНЕС ВНИЗ ПО РЕКОМЕНДАЦИИ ЖПТ
## autoload completions for plugins
#autoload -U compinit && compinit
#
# Optimised
autoload -Uz compinit
compinit -C

## fucking ruby versioning staff
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
#
# функция-заглушка
rbenv() {
  unset -f rbenv                  # убираем эту функцию после первого вызова
  eval "$(command rbenv init -)"  # реально инициализируем rbenv
  rbenv "$@"                      # передаём все аргументы оригинальному rbenv
}

## brew shit
export HOMEBREW_NO_ENV_HINTS=1
export PATH="$HOMEBREW_PREFIX/opt/ruby/bin:$PATH"
for GEMBIN in "$HOMEBREW_PREFIX"/lib/ruby/gems/*/bin(N); do export PATH="$GEMBIN:$PATH"; done; unset GEMBIN
export PATH="$HOMEBREW_PREFIX/opt/curl/bin:$PATH"
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
